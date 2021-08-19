Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1F3F1727
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhHSKQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Aug 2021 06:16:26 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:59926 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:16:25 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 17JAFJ7M031214; Thu, 19 Aug 2021 19:15:19 +0900
X-Iguazu-Qid: 34trpS1ar6PFTpFjb1
X-Iguazu-QSIG: v=2; s=0; t=1629368119; q=34trpS1ar6PFTpFjb1; m=34OHU9vZp4Wklx6tNgmAax1aefZ++4BN/iDhKv0PK88=
Received: from CNN1EMTA02.test.kioxia.com ([202.248.33.144])
        by relay.securemx.jp (mx-mr1510) id 17JAFIHs038850;
        Thu, 19 Aug 2021 19:15:18 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
        by CNN1EMTA02.test.kioxia.com (Postfix) with ESMTP id 23CC12F00E;
        Thu, 19 Aug 2021 19:15:18 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
        by Switcher-Post_Send (Postfix) with ESMTP id 763781907AD215;
        Thu, 19 Aug 2021 19:12:55 +0900 (JST)
Received: from localhost [127.0.0.1] 
         by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA0124J;
         Thu, 19 Aug 2021 19:12:55 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
        by Switcher-Pre_Send (Postfix) with ESMTP id 6B40EA035A340;
        Thu, 19 Aug 2021 19:12:55 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 19:15:17 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Thu,
 19 Aug 2021 19:15:17 +0900
From:   sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Index: AdeHNEBfLn7U7T5+SsyG/rbRVH2ESP//rzwA//3+YZCACVBBgP/rod7A
Date:   Thu, 19 Aug 2021 10:15:17 +0000
Message-ID: <00dc78e1d94d4b1d841214b3f0801603@kioxia.com>
References: <b7cde4c23c44485198f12739bb8fbca0@kioxia.com>
 <202108021253.QwqCWvYe-lkp@intel.com>
 <1f5231f5d0d14829ae72aa97e5f2487a@kioxia.com>
 <06929ff1-107f-c00e-7fd9-3c8999e26051@grimberg.me>
In-Reply-To: <06929ff1-107f-c00e-7fd9-3c8999e26051@grimberg.me>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.40.54]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB01.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB01.r1.kioxia.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is too specific. I'd move it to nvme_user_cmd_post similar to how
> we handle passthru commands (with start/end that does stuff based on the
> effects)

Thank you for your comment.
I will recreate this patch which adds nvme_user_cmd_post
for update keep alive timer and move update routine to core.c.

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Saturday, August 7, 2021 5:07 AM
To: sasaki tatsuya(佐々木 達哉 ＫＩＣ ○Ｓ技Ｃ□ＳＳ開○ＳＳ一) <tatsuya6.sasaki@kioxia.com>; kernel test robot <lkp@intel.com>; kbusch@kernel.org; axboe@fb.com; hch@lst.de; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: update keep alive interval when kato is modified



On 8/2/21 7:12 PM, sasaki tatsuya wrote:
> Currently the connection between host and NVMe-oF target gets
> disconnected by keep-alive timeout when a user connects to a target
> with a relatively large kato value and then sets the smaller kato
> with a set features command (e.g. connects with 60 seconds kato value
> and then sets 10 seconds kato value).
> 
> The cause is that keep alive command interval on the host, which is
> defined as unsigned int kato in nvme_ctrl structure, does not follow
> the kato value changes.
> 
> This patch updates the keep alive interval in the following steps when
> the kato is modified by a set features command: stops the keep alive
> work queue, then sets the kato as new timer value and re-start the queue.
> 
> Signed-off-by: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>
> ---
>   drivers/nvme/host/core.c  |  3 ++-
>   drivers/nvme/host/ioctl.c | 17 +++++++++++++++++
>   drivers/nvme/host/nvme.h  |  1 +
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..89c52da15618 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1255,13 +1255,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
>   	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
>   }
>   
> -static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
> +void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
>   {
>   	if (unlikely(ctrl->kato == 0))
>   		return;
>   
>   	nvme_queue_keep_alive_work(ctrl);
>   }
> +EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
>   
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 305ddd415e45..0066728e77b2 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -231,6 +231,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   			return -EFAULT;
>   	}
>   
> +	/*
> +	 * Keep alive commands interval on the host should be updated
> +	 * when KATO is modified by Set Features commands.
> +	 */

This is too specific. I'd move it to nvme_user_cmd_post similar to how
we handle passthru commands (with start/end that does stuff based on the
effects)

> +	if (!status && cmd.opcode == nvme_admin_set_features &&
> +	    (cmd.cdw10 & 0xFF) == NVME_FEAT_KATO) {
> +		/* ms -> s */
> +		unsigned int new_kato = DIV_ROUND_UP(cmd.cdw11, 1000);
> +

The section below needs to move to a core rountine:
nvme_update_keep_alive()

> +		dev_info(ctrl->device,
> +			 "keep alive commands interval on the host is updated from %u milliseconds to %u milliseconds\n",
> +			 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> +		nvme_stop_keep_alive(ctrl);
> +		ctrl->kato = new_kato;
> +		nvme_start_keep_alive(ctrl);
> +	}
> +
>   	return status;
>   }
>  

