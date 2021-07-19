Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFA3CD731
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbhGSOLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 10:11:41 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:51684 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241412AbhGSOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:11:14 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JEnoJ0014950;
        Mon, 19 Jul 2021 14:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=8Yvl+WP5QfyYTrjRJ7cx0ZMjESfC6CIviCwNYldXE70=;
 b=njaLMiIoedpBK2xrMztc5aNQ4UGVM4yRxZbLfukilonsRhUaXXqbVHbn4fFq4mHjbFtf
 VPK8L5Xz5wW8AQpSTBZR44m0DEEF2n2l+4cSf/bvitSu0NSyJE0dvib7z6cZsWfuYQjd
 53+c7+GYk6AzX5tMyPna6bfnEnnMLW80ZkbkqqtfGNIsaNgsAHpFumcGFkxKy4CJIemo
 TnRskd38it5w0lIXPh/btsEZd0/kjY+kIOVqo+rnDI+yDp4sJ0gO/UXOJXs2UUqLlkY3
 41/VHNmbbP2l4REn6EKp5GL1+2Z+hzVFAK56aKntBXDOAGqOeqFH0lEB195HKsiyt2Gf Lg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 39vyutwp2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 14:51:40 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id A18854E;
        Mon, 19 Jul 2021 14:51:38 +0000 (UTC)
Received: from hpe.com (unknown [16.99.166.31])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 98D0546;
        Mon, 19 Jul 2021 14:51:36 +0000 (UTC)
Date:   Mon, 19 Jul 2021 09:51:36 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: Convert from atomic_t to refcount_t on
 gru_thread_state->ts_refcnt
Message-ID: <20210719145136.GA4844@hpe.com>
References: <1626517043-42696-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626517043-42696-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Proofpoint-GUID: cHzvWadgvYk3WoDC1ypOEBr5Hc6pcpyH
X-Proofpoint-ORIG-GUID: cHzvWadgvYk3WoDC1ypOEBr5Hc6pcpyH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Sat, Jul 17, 2021 at 06:17:22PM +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/misc/sgi-gru/grumain.c   | 6 +++---
>  drivers/misc/sgi-gru/grutables.h | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 40ac59dd018c..9afda47efbf2 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -282,7 +282,7 @@ static void gru_unload_mm_tracker(struct gru_state *gru,
>   */
>  void gts_drop(struct gru_thread_state *gts)
>  {
> -	if (gts && atomic_dec_return(&gts->ts_refcnt) == 0) {
> +	if (gts && refcount_dec_and_test(&gts->ts_refcnt)) {
>  		if (gts->ts_gms)
>  			gru_drop_mmu_notifier(gts->ts_gms);
>  		kfree(gts);
> @@ -323,7 +323,7 @@ struct gru_thread_state *gru_alloc_gts(struct vm_area_struct *vma,
>  
>  	STAT(gts_alloc);
>  	memset(gts, 0, sizeof(struct gru_thread_state)); /* zero out header */
> -	atomic_set(&gts->ts_refcnt, 1);
> +	refcount_set(&gts->ts_refcnt, 1);
>  	mutex_init(&gts->ts_ctxlock);
>  	gts->ts_cbr_au_count = cbr_au_count;
>  	gts->ts_dsr_au_count = dsr_au_count;
> @@ -888,7 +888,7 @@ struct gru_state *gru_assign_gru_context(struct gru_thread_state *gts)
>  		gts->ts_gru = gru;
>  		gts->ts_blade = gru->gs_blade_id;
>  		gts->ts_ctxnum = gru_assign_context_number(gru);
> -		atomic_inc(&gts->ts_refcnt);
> +		refcount_inc(&gts->ts_refcnt);
>  		gru->gs_gts[gts->ts_ctxnum] = gts;
>  		spin_unlock(&gru->gs_lock);
>  
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index 5ce8f3081e96..e4c067c61251 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -129,6 +129,7 @@
>   *
>   */
>  
> +#include <linux/refcount.h>
>  #include <linux/rmap.h>
>  #include <linux/interrupt.h>
>  #include <linux/mutex.h>
> @@ -358,7 +359,7 @@ struct gru_thread_state {
>  						     enabled */
>  	int			ts_ctxnum;	/* context number where the
>  						   context is loaded */
> -	atomic_t		ts_refcnt;	/* reference count GTS */
> +	refcount_t		ts_refcnt;	/* reference count GTS */
>  	unsigned char		ts_dsr_au_count;/* Number of DSR resources
>  						   required for contest */
>  	unsigned char		ts_cbr_au_count;/* Number of CBR resources
> -- 
> 2.7.4
