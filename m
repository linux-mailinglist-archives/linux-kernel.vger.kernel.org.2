Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28325371377
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhECKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:14:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhECKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:14:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143AAeRn049245;
        Mon, 3 May 2021 10:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=OUywxQuq0beT1criVfMaRwe5fDhQJHdxvXBVMS+TwoM=;
 b=keoBMmV7ZgLU6I7hUB3EoPfypddUUjcjJdOTBhnKCrE5ZQb3DKHgMJJxYSYlKpjrVxIz
 I0yFRK7X9Rkc0rgOVAjIBYceGAdZ3UnWXGzKyEpTeUpxUPdnt3kBnDFSmlBTD/oD61KO
 9ZgsUgmQputdkCl10cqVvRA0E10JpNah5c5n+srDZoQ2/yehR/yxT3OlAXcQreh24kRz
 WVfyXNhlpsOO8tEEbAJaffQNvEN9J5pBCMI+e6QneHhTfrZZgCdkrQkdlaIK+OsFy1+2
 dLisVIBNNNq5+kcqo+w6QuHtSELEn3m8OJEu03G3+2bSGRPMkwpM+vPFEp7VCcq7K95N lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 388vgbk8ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:13:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143ABJ1a155229;
        Mon, 3 May 2021 10:13:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 388w1cdy7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:13:08 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143AD7qr164348;
        Mon, 3 May 2021 10:13:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 388w1cdy72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:13:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 143AD2bd009594;
        Mon, 3 May 2021 10:13:03 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 03:13:02 -0700
Date:   Mon, 3 May 2021 13:12:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kernel/hw_breakpoint.c:715 hw_breakpoint_handler()
 error: uninitialized symbol 'ea'.
Message-ID: <202105020133.kpE5qyo9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: gCZFsyPW_OPaQySH_ekBYFoNrNNOrO_m
X-Proofpoint-ORIG-GUID: gCZFsyPW_OPaQySH_ekBYFoNrNNOrO_m
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f67672a817ec046f7554a885f0fe0d60e1bf99f
commit: f6780ce619f8daa285760302d56e95892087bd1f powerpc/watchpoint: Fix DAWR exception constraint
config: powerpc-randconfig-m031-20210501 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
arch/powerpc/kernel/hw_breakpoint.c:715 hw_breakpoint_handler() error: uninitialized symbol 'ea'.

vim +/ea +715 arch/powerpc/kernel/hw_breakpoint.c

03465f899bdac7 Nicholas Piggin  2016-09-16  677  int hw_breakpoint_handler(struct die_args *args)
5aae8a53708025 K.Prasad         2010-06-15  678  {
74c6881019b7d5 Ravi Bangoria    2020-05-14  679  	bool err = false;
5aae8a53708025 K.Prasad         2010-06-15  680  	int rc = NOTIFY_STOP;
74c6881019b7d5 Ravi Bangoria    2020-05-14  681  	struct perf_event *bp[HBP_NUM_MAX] = { NULL };
5aae8a53708025 K.Prasad         2010-06-15  682  	struct pt_regs *regs = args->regs;
74c6881019b7d5 Ravi Bangoria    2020-05-14  683  	struct arch_hw_breakpoint *info[HBP_NUM_MAX] = { NULL };
74c6881019b7d5 Ravi Bangoria    2020-05-14  684  	int i;
74c6881019b7d5 Ravi Bangoria    2020-05-14  685  	int hit[HBP_NUM_MAX] = {0};
74c6881019b7d5 Ravi Bangoria    2020-05-14  686  	int nr_hit = 0;
74c6881019b7d5 Ravi Bangoria    2020-05-14  687  	bool ptrace_bp = false;
74c6881019b7d5 Ravi Bangoria    2020-05-14  688  	struct ppc_inst instr = ppc_inst(0);
74c6881019b7d5 Ravi Bangoria    2020-05-14  689  	int type = 0;
74c6881019b7d5 Ravi Bangoria    2020-05-14  690  	int size = 0;
f6780ce619f8da Ravi Bangoria    2020-07-23  691  	unsigned long ea;
5aae8a53708025 K.Prasad         2010-06-15  692  
5aae8a53708025 K.Prasad         2010-06-15  693  	/* Disable breakpoints during exception handling */
9422de3e953d0e Michael Neuling  2012-12-20  694  	hw_breakpoint_disable();
574cb24899d35e Paul Mackerras   2010-06-23  695  
5aae8a53708025 K.Prasad         2010-06-15  696  	/*
5aae8a53708025 K.Prasad         2010-06-15  697  	 * The counter may be concurrently released but that can only
5aae8a53708025 K.Prasad         2010-06-15  698  	 * occur from a call_rcu() path. We can then safely fetch
5aae8a53708025 K.Prasad         2010-06-15  699  	 * the breakpoint, use its callback, touch its counter
5aae8a53708025 K.Prasad         2010-06-15  700  	 * while we are in an rcu_read_lock() path.
5aae8a53708025 K.Prasad         2010-06-15  701  	 */
5aae8a53708025 K.Prasad         2010-06-15  702  	rcu_read_lock();
5aae8a53708025 K.Prasad         2010-06-15  703  
74c6881019b7d5 Ravi Bangoria    2020-05-14  704  	if (!IS_ENABLED(CONFIG_PPC_8xx))
f6780ce619f8da Ravi Bangoria    2020-07-23  705  		get_instr_detail(regs, &instr, &type, &size, &ea);

No else path.

74c6881019b7d5 Ravi Bangoria    2020-05-14  706  
74c6881019b7d5 Ravi Bangoria    2020-05-14  707  	for (i = 0; i < nr_wp_slots(); i++) {
74c6881019b7d5 Ravi Bangoria    2020-05-14  708  		bp[i] = __this_cpu_read(bp_per_reg[i]);
74c6881019b7d5 Ravi Bangoria    2020-05-14  709  		if (!bp[i])
74c6881019b7d5 Ravi Bangoria    2020-05-14  710  			continue;
74c6881019b7d5 Ravi Bangoria    2020-05-14  711  
74c6881019b7d5 Ravi Bangoria    2020-05-14  712  		info[i] = counter_arch_bp(bp[i]);
74c6881019b7d5 Ravi Bangoria    2020-05-14  713  		info[i]->type &= ~HW_BRK_TYPE_EXTRANEOUS_IRQ;
74c6881019b7d5 Ravi Bangoria    2020-05-14  714  
f6780ce619f8da Ravi Bangoria    2020-07-23 @715  		if (check_constraints(regs, instr, ea, type, size, info[i])) {
                                                                                                   ^^
Passing uninitialized data to a function will trigger a KUBSan warning
at runtime regardless of whether or not the parameter is used.  (Unless
the compiler inlines the function then it would be fine).

74c6881019b7d5 Ravi Bangoria    2020-05-14  716  			if (!IS_ENABLED(CONFIG_PPC_8xx) &&
74c6881019b7d5 Ravi Bangoria    2020-05-14  717  			    ppc_inst_equal(instr, ppc_inst(0))) {
74c6881019b7d5 Ravi Bangoria    2020-05-14  718  				handler_error(bp[i], info[i]);
74c6881019b7d5 Ravi Bangoria    2020-05-14  719  				info[i] = NULL;
74c6881019b7d5 Ravi Bangoria    2020-05-14  720  				err = 1;
74c6881019b7d5 Ravi Bangoria    2020-05-14  721  				continue;
74c6881019b7d5 Ravi Bangoria    2020-05-14  722  			}
74c6881019b7d5 Ravi Bangoria    2020-05-14  723  
74c6881019b7d5 Ravi Bangoria    2020-05-14  724  			if (is_ptrace_bp(bp[i]))

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

