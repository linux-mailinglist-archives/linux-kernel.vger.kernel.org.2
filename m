Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527AE327D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhCAL2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:28:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13100 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhCAL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:28:08 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DpycP1WMyz16F3T;
        Mon,  1 Mar 2021 19:25:41 +0800 (CST)
Received: from [10.174.179.20] (10.174.179.20) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 19:27:19 +0800
Subject: Re: [PATCH] hugetlb_cgroup: fix imbalanced css_get and css_put pair
 for shared mappings
To:     kernel test robot <lkp@intel.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <almasrymina@google.com>, <rientjes@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210210091606.21051-1-linmiaohe@huawei.com>
 <202102102343.ZEKIAzJ1-lkp@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <38553e50-3271-fa50-a440-b2b0b4c44aef@huawei.com>
Date:   Mon, 1 Mar 2021 19:27:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202102102343.ZEKIAzJ1-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.20]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/10 23:32, kernel test robot wrote:
> Hi Miaohe,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20210125]
> [also build test ERROR on v5.11-rc7]
> [cannot apply to linux/master linus/master hnaz-linux-mm/master v5.11-rc7 v5.11-rc6 v5.11-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Miaohe-Lin/hugetlb_cgroup-fix-imbalanced-css_get-and-css_put-pair-for-shared-mappings/20210210-171736
> base:    59fa6a163ffabc1bf25c5e0e33899e268a96d3cc
> config: arm64-randconfig-r025-20210209 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project c9439ca36342fb6013187d0a69aef92736951476)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/68f4ed1b80aa7c51a921c3ad913ee7e6e00618d0
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Miaohe-Lin/hugetlb_cgroup-fix-imbalanced-css_get-and-css_put-pair-for-shared-mappings/20210210-171736
>         git checkout 68f4ed1b80aa7c51a921c3ad913ee7e6e00618d0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/hugetlb.c:5222:17: error: incomplete definition of type 'struct hugetlb_cgroup'
>                            css_put(&h_cg->css);
>                                     ~~~~^
>    include/linux/hugetlb_cgroup.h:20:8: note: forward declaration of 'struct hugetlb_cgroup'
>    struct hugetlb_cgroup;
>           ^
>    1 error generated.
> 

Sorry for late respond. Will fix this. Thanks!

> 
> vim +5222 mm/hugetlb.c
> 
>   5091	
>   5092	/* Return true if reservation was successful, false otherwise.  */
>   5093	bool hugetlb_reserve_pages(struct inode *inode,
>   5094						long from, long to,
>   5095						struct vm_area_struct *vma,
>   5096						vm_flags_t vm_flags)
>   5097	{
>   5098		long chg, add = -1;
>   5099		struct hstate *h = hstate_inode(inode);
>   5100		struct hugepage_subpool *spool = subpool_inode(inode);
>   5101		struct resv_map *resv_map;
>   5102		struct hugetlb_cgroup *h_cg = NULL;
>   5103		long gbl_reserve, regions_needed = 0;
>   5104	
>   5105		/* This should never happen */
>   5106		if (from > to) {
>   5107			VM_WARN(1, "%s called with a negative range\n", __func__);
>   5108			return false;
>   5109		}
>   5110	
>   5111		/*
>   5112		 * Only apply hugepage reservation if asked. At fault time, an
>   5113		 * attempt will be made for VM_NORESERVE to allocate a page
>   5114		 * without using reserves
>   5115		 */
>   5116		if (vm_flags & VM_NORESERVE)
>   5117			return true;
>   5118	
>   5119		/*
>   5120		 * Shared mappings base their reservation on the number of pages that
>   5121		 * are already allocated on behalf of the file. Private mappings need
>   5122		 * to reserve the full area even if read-only as mprotect() may be
>   5123		 * called to make the mapping read-write. Assume !vma is a shm mapping
>   5124		 */
>   5125		if (!vma || vma->vm_flags & VM_MAYSHARE) {
>   5126			/*
>   5127			 * resv_map can not be NULL as hugetlb_reserve_pages is only
>   5128			 * called for inodes for which resv_maps were created (see
>   5129			 * hugetlbfs_get_inode).
>   5130			 */
>   5131			resv_map = inode_resv_map(inode);
>   5132	
>   5133			chg = region_chg(resv_map, from, to, &regions_needed);
>   5134	
>   5135		} else {
>   5136			/* Private mapping. */
>   5137			resv_map = resv_map_alloc();
>   5138			if (!resv_map)
>   5139				return false;
>   5140	
>   5141			chg = to - from;
>   5142	
>   5143			set_vma_resv_map(vma, resv_map);
>   5144			set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
>   5145		}
>   5146	
>   5147		if (chg < 0)
>   5148			goto out_err;
>   5149	
>   5150		if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
>   5151					chg * pages_per_huge_page(h), &h_cg) < 0)
>   5152			goto out_err;
>   5153	
>   5154		if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
>   5155			/* For private mappings, the hugetlb_cgroup uncharge info hangs
>   5156			 * of the resv_map.
>   5157			 */
>   5158			resv_map_set_hugetlb_cgroup_uncharge_info(resv_map, h_cg, h);
>   5159		}
>   5160	
>   5161		/*
>   5162		 * There must be enough pages in the subpool for the mapping. If
>   5163		 * the subpool has a minimum size, there may be some global
>   5164		 * reservations already in place (gbl_reserve).
>   5165		 */
>   5166		gbl_reserve = hugepage_subpool_get_pages(spool, chg);
>   5167		if (gbl_reserve < 0)
>   5168			goto out_uncharge_cgroup;
>   5169	
>   5170		/*
>   5171		 * Check enough hugepages are available for the reservation.
>   5172		 * Hand the pages back to the subpool if there are not
>   5173		 */
>   5174		if (hugetlb_acct_memory(h, gbl_reserve) < 0)
>   5175			goto out_put_pages;
>   5176	
>   5177		/*
>   5178		 * Account for the reservations made. Shared mappings record regions
>   5179		 * that have reservations as they are shared by multiple VMAs.
>   5180		 * When the last VMA disappears, the region map says how much
>   5181		 * the reservation was and the page cache tells how much of
>   5182		 * the reservation was consumed. Private mappings are per-VMA and
>   5183		 * only the consumed reservations are tracked. When the VMA
>   5184		 * disappears, the original reservation is the VMA size and the
>   5185		 * consumed reservations are stored in the map. Hence, nothing
>   5186		 * else has to be done for private mappings here
>   5187		 */
>   5188		if (!vma || vma->vm_flags & VM_MAYSHARE) {
>   5189			add = region_add(resv_map, from, to, regions_needed, h, h_cg);
>   5190	
>   5191			if (unlikely(add < 0)) {
>   5192				hugetlb_acct_memory(h, -gbl_reserve);
>   5193				goto out_put_pages;
>   5194			} else if (unlikely(chg > add)) {
>   5195				/*
>   5196				 * pages in this range were added to the reserve
>   5197				 * map between region_chg and region_add.  This
>   5198				 * indicates a race with alloc_huge_page.  Adjust
>   5199				 * the subpool and reserve counts modified above
>   5200				 * based on the difference.
>   5201				 */
>   5202				long rsv_adjust;
>   5203	
>   5204				/*
>   5205				 * hugetlb_cgroup_uncharge_cgroup_rsvd() will put the
>   5206				 * reference to h_cg->css. See comment below for detail.
>   5207				 */
>   5208				hugetlb_cgroup_uncharge_cgroup_rsvd(
>   5209					hstate_index(h),
>   5210					(chg - add) * pages_per_huge_page(h), h_cg);
>   5211	
>   5212				rsv_adjust = hugepage_subpool_put_pages(spool,
>   5213									chg - add);
>   5214				hugetlb_acct_memory(h, -rsv_adjust);
>   5215			} else if (h_cg) {
>   5216				/*
>   5217				 * The file_regions will hold their own reference to
>   5218				 * h_cg->css. So we should release the reference held
>   5219				 * via hugetlb_cgroup_charge_cgroup_rsvd() when we are
>   5220				 * done.
>   5221				 */
>> 5222				css_put(&h_cg->css);
>   5223			}
>   5224		}
>   5225		return true;
>   5226	
>   5227	out_put_pages:
>   5228		/* put back original number of pages, chg */
>   5229		(void)hugepage_subpool_put_pages(spool, chg);
>   5230	out_uncharge_cgroup:
>   5231		hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
>   5232						    chg * pages_per_huge_page(h), h_cg);
>   5233	out_err:
>   5234		if (!vma || vma->vm_flags & VM_MAYSHARE)
>   5235			/* Only call region_abort if the region_chg succeeded but the
>   5236			 * region_add failed or didn't run.
>   5237			 */
>   5238			if (chg >= 0 && add < 0)
>   5239				region_abort(resv_map, from, to, regions_needed);
>   5240		if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
>   5241			kref_put(&resv_map->refs, resv_map_release);
>   5242		return false;
>   5243	}
>   5244	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

