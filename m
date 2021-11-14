Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB244FC73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 00:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhKNXZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 18:25:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:8138 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhKNXYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 18:24:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230810918"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="gz'50?scan'50,208,50";a="230810918"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 15:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="gz'50?scan'50,208,50";a="535321488"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2021 15:21:54 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmOor-000Lt4-U7; Sun, 14 Nov 2021 23:21:53 +0000
Date:   Mon, 15 Nov 2021 07:21:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ast-bpf:relo_core 9/19] tools/lib/bpf/relo_core.c:1348:1: warning:
 the frame size of 1136 bytes is larger than 1024 bytes
Message-ID: <202111150714.YtXpXXkY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git relo_core
head:   f17ef55e5e0bac0d11d3186cd1c468b5a1e047d7
commit: 03c354f8c71c2478c421d5552d284e0befb03861 [9/19] bpf: Prepare relo_core.c for kernel duty.
config: arc-randconfig-r043-20211115 (attached as .config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?id=03c354f8c71c2478c421d5552d284e0befb03861
        git remote add ast-bpf https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git
        git fetch --no-tags ast-bpf relo_core
        git checkout 03c354f8c71c2478c421d5552d284e0befb03861
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   tools/lib/bpf/relo_core.c: In function 'bpf_core_apply_relo_insn':
>> tools/lib/bpf/relo_core.c:1348:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1348 | }
         | ^


vim +1348 tools/lib/bpf/relo_core.c

b0588390dbcedc Alexei Starovoitov 2021-07-20  1147  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1148  /*
b0588390dbcedc Alexei Starovoitov 2021-07-20  1149   * CO-RE relocate single instruction.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1150   *
b0588390dbcedc Alexei Starovoitov 2021-07-20  1151   * The outline and important points of the algorithm:
b0588390dbcedc Alexei Starovoitov 2021-07-20  1152   * 1. For given local type, find corresponding candidate target types.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1153   *    Candidate type is a type with the same "essential" name, ignoring
b0588390dbcedc Alexei Starovoitov 2021-07-20  1154   *    everything after last triple underscore (___). E.g., `sample`,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1155   *    `sample___flavor_one`, `sample___flavor_another_one`, are all candidates
b0588390dbcedc Alexei Starovoitov 2021-07-20  1156   *    for each other. Names with triple underscore are referred to as
b0588390dbcedc Alexei Starovoitov 2021-07-20  1157   *    "flavors" and are useful, among other things, to allow to
b0588390dbcedc Alexei Starovoitov 2021-07-20  1158   *    specify/support incompatible variations of the same kernel struct, which
b0588390dbcedc Alexei Starovoitov 2021-07-20  1159   *    might differ between different kernel versions and/or build
b0588390dbcedc Alexei Starovoitov 2021-07-20  1160   *    configurations.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1161   *
b0588390dbcedc Alexei Starovoitov 2021-07-20  1162   *    N.B. Struct "flavors" could be generated by bpftool's BTF-to-C
b0588390dbcedc Alexei Starovoitov 2021-07-20  1163   *    converter, when deduplicated BTF of a kernel still contains more than
b0588390dbcedc Alexei Starovoitov 2021-07-20  1164   *    one different types with the same name. In that case, ___2, ___3, etc
b0588390dbcedc Alexei Starovoitov 2021-07-20  1165   *    are appended starting from second name conflict. But start flavors are
b0588390dbcedc Alexei Starovoitov 2021-07-20  1166   *    also useful to be defined "locally", in BPF program, to extract same
b0588390dbcedc Alexei Starovoitov 2021-07-20  1167   *    data from incompatible changes between different kernel
b0588390dbcedc Alexei Starovoitov 2021-07-20  1168   *    versions/configurations. For instance, to handle field renames between
b0588390dbcedc Alexei Starovoitov 2021-07-20  1169   *    kernel versions, one can use two flavors of the struct name with the
b0588390dbcedc Alexei Starovoitov 2021-07-20  1170   *    same common name and use conditional relocations to extract that field,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1171   *    depending on target kernel version.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1172   * 2. For each candidate type, try to match local specification to this
b0588390dbcedc Alexei Starovoitov 2021-07-20  1173   *    candidate target type. Matching involves finding corresponding
b0588390dbcedc Alexei Starovoitov 2021-07-20  1174   *    high-level spec accessors, meaning that all named fields should match,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1175   *    as well as all array accesses should be within the actual bounds. Also,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1176   *    types should be compatible (see bpf_core_fields_are_compat for details).
b0588390dbcedc Alexei Starovoitov 2021-07-20  1177   * 3. It is supported and expected that there might be multiple flavors
b0588390dbcedc Alexei Starovoitov 2021-07-20  1178   *    matching the spec. As long as all the specs resolve to the same set of
b0588390dbcedc Alexei Starovoitov 2021-07-20  1179   *    offsets across all candidates, there is no error. If there is any
b0588390dbcedc Alexei Starovoitov 2021-07-20  1180   *    ambiguity, CO-RE relocation will fail. This is necessary to accomodate
b0588390dbcedc Alexei Starovoitov 2021-07-20  1181   *    imprefection of BTF deduplication, which can cause slight duplication of
b0588390dbcedc Alexei Starovoitov 2021-07-20  1182   *    the same BTF type, if some directly or indirectly referenced (by
b0588390dbcedc Alexei Starovoitov 2021-07-20  1183   *    pointer) type gets resolved to different actual types in different
b0588390dbcedc Alexei Starovoitov 2021-07-20  1184   *    object files. If such situation occurs, deduplicated BTF will end up
b0588390dbcedc Alexei Starovoitov 2021-07-20  1185   *    with two (or more) structurally identical types, which differ only in
b0588390dbcedc Alexei Starovoitov 2021-07-20  1186   *    types they refer to through pointer. This should be OK in most cases and
b0588390dbcedc Alexei Starovoitov 2021-07-20  1187   *    is not an error.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1188   * 4. Candidate types search is performed by linearly scanning through all
b0588390dbcedc Alexei Starovoitov 2021-07-20  1189   *    types in target BTF. It is anticipated that this is overall more
b0588390dbcedc Alexei Starovoitov 2021-07-20  1190   *    efficient memory-wise and not significantly worse (if not better)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1191   *    CPU-wise compared to prebuilding a map from all local type names to
b0588390dbcedc Alexei Starovoitov 2021-07-20  1192   *    a list of candidate type names. It's also sped up by caching resolved
b0588390dbcedc Alexei Starovoitov 2021-07-20  1193   *    list of matching candidates per each local "root" type ID, that has at
b0588390dbcedc Alexei Starovoitov 2021-07-20  1194   *    least one bpf_core_relo associated with it. This list is shared
b0588390dbcedc Alexei Starovoitov 2021-07-20  1195   *    between multiple relocations for the same type ID and is updated as some
b0588390dbcedc Alexei Starovoitov 2021-07-20  1196   *    of the candidates are pruned due to structural incompatibility.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1197   */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1198  int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1199  			     int insn_idx,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1200  			     const struct bpf_core_relo *relo,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1201  			     int relo_idx,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1202  			     const struct btf *local_btf,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1203  			     struct bpf_core_cand_list *cands)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1204  {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1205  	struct bpf_core_spec local_spec, cand_spec, targ_spec = {};
b0588390dbcedc Alexei Starovoitov 2021-07-20  1206  	struct bpf_core_relo_res cand_res, targ_res;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1207  	const struct btf_type *local_type;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1208  	const char *local_name;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1209  	__u32 local_id;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1210  	const char *spec_str;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1211  	int i, j, err;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1212  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1213  	local_id = relo->type_id;
9954f5c668fde7 Alexei Starovoitov 2021-09-30  1214  	local_type = btf_type_by_id(local_btf, local_id);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1215  	if (!local_type)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1216  		return -EINVAL;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1217  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1218  	local_name = btf__name_by_offset(local_btf, local_type->name_off);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1219  	if (!local_name)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1220  		return -EINVAL;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1221  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1222  	spec_str = btf__name_by_offset(local_btf, relo->access_str_off);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1223  	if (str_is_empty(spec_str))
b0588390dbcedc Alexei Starovoitov 2021-07-20  1224  		return -EINVAL;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1225  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1226  	err = bpf_core_parse_spec(local_btf, local_id, spec_str, relo->kind, &local_spec);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1227  	if (err) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1228  		pr_warn("prog '%s': relo #%d: parsing [%d] %s %s + %s failed: %d\n",
b0588390dbcedc Alexei Starovoitov 2021-07-20  1229  			prog_name, relo_idx, local_id, btf_kind_str(local_type),
b0588390dbcedc Alexei Starovoitov 2021-07-20  1230  			str_is_empty(local_name) ? "<anon>" : local_name,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1231  			spec_str, err);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1232  		return -EINVAL;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1233  	}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1234  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1235  	pr_debug("prog '%s': relo #%d: kind <%s> (%d), spec is ", prog_name,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1236  		 relo_idx, core_relo_kind_str(relo->kind), relo->kind);
03c354f8c71c24 Alexei Starovoitov 2021-09-07  1237  	bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, &local_spec);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1238  	libbpf_print(LIBBPF_DEBUG, "\n");
b0588390dbcedc Alexei Starovoitov 2021-07-20  1239  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1240  	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1241  	if (relo->kind == BPF_TYPE_ID_LOCAL) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1242  		targ_res.validate = true;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1243  		targ_res.poison = false;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1244  		targ_res.orig_val = local_spec.root_type_id;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1245  		targ_res.new_val = local_spec.root_type_id;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1246  		goto patch_insn;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1247  	}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1248  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1249  	/* libbpf doesn't support candidate search for anonymous types */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1250  	if (str_is_empty(spec_str)) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1251  		pr_warn("prog '%s': relo #%d: <%s> (%d) relocation doesn't support anonymous types\n",
b0588390dbcedc Alexei Starovoitov 2021-07-20  1252  			prog_name, relo_idx, core_relo_kind_str(relo->kind), relo->kind);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1253  		return -EOPNOTSUPP;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1254  	}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1255  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1256  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1257  	for (i = 0, j = 0; i < cands->len; i++) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1258  		err = bpf_core_spec_match(&local_spec, cands->cands[i].btf,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1259  					  cands->cands[i].id, &cand_spec);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1260  		if (err < 0) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1261  			pr_warn("prog '%s': relo #%d: error matching candidate #%d ",
b0588390dbcedc Alexei Starovoitov 2021-07-20  1262  				prog_name, relo_idx, i);
03c354f8c71c24 Alexei Starovoitov 2021-09-07  1263  			bpf_core_dump_spec(prog_name, LIBBPF_WARN, &cand_spec);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1264  			libbpf_print(LIBBPF_WARN, ": %d\n", err);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1265  			return err;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1266  		}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1267  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1268  		pr_debug("prog '%s': relo #%d: %s candidate #%d ", prog_name,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1269  			 relo_idx, err == 0 ? "non-matching" : "matching", i);
03c354f8c71c24 Alexei Starovoitov 2021-09-07  1270  		bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, &cand_spec);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1271  		libbpf_print(LIBBPF_DEBUG, "\n");
b0588390dbcedc Alexei Starovoitov 2021-07-20  1272  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1273  		if (err == 0)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1274  			continue;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1275  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1276  		err = bpf_core_calc_relo(prog_name, relo, relo_idx, &local_spec, &cand_spec, &cand_res);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1277  		if (err)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1278  			return err;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1279  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1280  		if (j == 0) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1281  			targ_res = cand_res;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1282  			targ_spec = cand_spec;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1283  		} else if (cand_spec.bit_offset != targ_spec.bit_offset) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1284  			/* if there are many field relo candidates, they
b0588390dbcedc Alexei Starovoitov 2021-07-20  1285  			 * should all resolve to the same bit offset
b0588390dbcedc Alexei Starovoitov 2021-07-20  1286  			 */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1287  			pr_warn("prog '%s': relo #%d: field offset ambiguity: %u != %u\n",
b0588390dbcedc Alexei Starovoitov 2021-07-20  1288  				prog_name, relo_idx, cand_spec.bit_offset,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1289  				targ_spec.bit_offset);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1290  			return -EINVAL;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1291  		} else if (cand_res.poison != targ_res.poison || cand_res.new_val != targ_res.new_val) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1292  			/* all candidates should result in the same relocation
b0588390dbcedc Alexei Starovoitov 2021-07-20  1293  			 * decision and value, otherwise it's dangerous to
b0588390dbcedc Alexei Starovoitov 2021-07-20  1294  			 * proceed due to ambiguity
b0588390dbcedc Alexei Starovoitov 2021-07-20  1295  			 */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1296  			pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %u != %s %u\n",
b0588390dbcedc Alexei Starovoitov 2021-07-20  1297  				prog_name, relo_idx,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1298  				cand_res.poison ? "failure" : "success", cand_res.new_val,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1299  				targ_res.poison ? "failure" : "success", targ_res.new_val);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1300  			return -EINVAL;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1301  		}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1302  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1303  		cands->cands[j++] = cands->cands[i];
b0588390dbcedc Alexei Starovoitov 2021-07-20  1304  	}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1305  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1306  	/*
b0588390dbcedc Alexei Starovoitov 2021-07-20  1307  	 * For BPF_FIELD_EXISTS relo or when used BPF program has field
b0588390dbcedc Alexei Starovoitov 2021-07-20  1308  	 * existence checks or kernel version/config checks, it's expected
b0588390dbcedc Alexei Starovoitov 2021-07-20  1309  	 * that we might not find any candidates. In this case, if field
b0588390dbcedc Alexei Starovoitov 2021-07-20  1310  	 * wasn't found in any candidate, the list of candidates shouldn't
b0588390dbcedc Alexei Starovoitov 2021-07-20  1311  	 * change at all, we'll just handle relocating appropriately,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1312  	 * depending on relo's kind.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1313  	 */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1314  	if (j > 0)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1315  		cands->len = j;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1316  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1317  	/*
b0588390dbcedc Alexei Starovoitov 2021-07-20  1318  	 * If no candidates were found, it might be both a programmer error,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1319  	 * as well as expected case, depending whether instruction w/
b0588390dbcedc Alexei Starovoitov 2021-07-20  1320  	 * relocation is guarded in some way that makes it unreachable (dead
b0588390dbcedc Alexei Starovoitov 2021-07-20  1321  	 * code) if relocation can't be resolved. This is handled in
b0588390dbcedc Alexei Starovoitov 2021-07-20  1322  	 * bpf_core_patch_insn() uniformly by replacing that instruction with
b0588390dbcedc Alexei Starovoitov 2021-07-20  1323  	 * BPF helper call insn (using invalid helper ID). If that instruction
b0588390dbcedc Alexei Starovoitov 2021-07-20  1324  	 * is indeed unreachable, then it will be ignored and eliminated by
b0588390dbcedc Alexei Starovoitov 2021-07-20  1325  	 * verifier. If it was an error, then verifier will complain and point
b0588390dbcedc Alexei Starovoitov 2021-07-20  1326  	 * to a specific instruction number in its log.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1327  	 */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1328  	if (j == 0) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1329  		pr_debug("prog '%s': relo #%d: no matching targets found\n",
b0588390dbcedc Alexei Starovoitov 2021-07-20  1330  			 prog_name, relo_idx);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1331  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1332  		/* calculate single target relo result explicitly */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1333  		err = bpf_core_calc_relo(prog_name, relo, relo_idx, &local_spec, NULL, &targ_res);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1334  		if (err)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1335  			return err;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1336  	}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1337  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1338  patch_insn:
b0588390dbcedc Alexei Starovoitov 2021-07-20  1339  	/* bpf_core_patch_insn() should know how to handle missing targ_spec */
b0588390dbcedc Alexei Starovoitov 2021-07-20  1340  	err = bpf_core_patch_insn(prog_name, insn, insn_idx, relo, relo_idx, &targ_res);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1341  	if (err) {
b0588390dbcedc Alexei Starovoitov 2021-07-20  1342  		pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %d\n",
b0588390dbcedc Alexei Starovoitov 2021-07-20  1343  			prog_name, relo_idx, relo->insn_off / 8, err);
b0588390dbcedc Alexei Starovoitov 2021-07-20  1344  		return -EINVAL;
b0588390dbcedc Alexei Starovoitov 2021-07-20  1345  	}
b0588390dbcedc Alexei Starovoitov 2021-07-20  1346  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1347  	return 0;
b0588390dbcedc Alexei Starovoitov 2021-07-20 @1348  }

:::::: The code at line 1348 was first introduced by commit
:::::: b0588390dbcedcd74fab6ffb8afe8d52380fd8b6 libbpf: Split CO-RE logic into relo_core.c.

:::::: TO: Alexei Starovoitov <ast@kernel.org>
:::::: CC: Andrii Nakryiko <andrii@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--8t9RHnE3ZwKMSgU+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/xe8G2jYZKMCAA==

--8t9RHnE3ZwKMSgU+--
