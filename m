Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F9B314D10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhBIKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:31:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:27717 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhBIKXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:23:32 -0500
IronPort-SDR: 0UTolwudQv90GV+r89Ryz1aI/wD2oNa+TMrY1RafiecnVOJDD9lBksQHtVf+4R1AUZw3WF3Ntd
 qShW43bMhY/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="266693432"
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="266693432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 02:22:45 -0800
IronPort-SDR: 6GVyllnocUdQJouo0REi4pOyG2lhiunbuhFioDlJBUT1vdDwy/MO/Sx5bwASMGznFhQURgd+Lw
 rRNT33Gn4Qiw==
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="396060985"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.51])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 02:22:43 -0800
Date:   Tue, 9 Feb 2021 10:22:35 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        gustavoars@kernel.org, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] drivers: crypto: qat: qat_common: Inside the comment a
 spelling fixed in adf_pf2vf_msg.c
Message-ID: <20210209102223.GA118045@silpixa00400314>
References: <20210203145506.11928-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203145506.11928-1-unixbhaskar@gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I'm going to consolidate this with the previous patch, improve the
commit message and resubmit.

Regards,

-- 
Giovanni

On Wed, Feb 03, 2021 at 08:25:06PM +0530, Bhaskar Chowdhury wrote:
> 
> s/messge/message/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
> index 8b090b7ae8c6..a1b77bd7a894 100644
> --- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
> +++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
> @@ -169,7 +169,7 @@ static int __adf_iov_putmsg(struct adf_accel_dev *accel_dev, u32 msg, u8 vf_nr)
>   * @msg:	Message to send
>   * @vf_nr:	VF number to which the message will be sent
>   *
> - * Function sends a messge from the PF to a VF
> + * Function sends a message from the PF to a VF
>   *
>   * Return: 0 on success, error code otherwise.
>   */
> --
> 2.26.2
> 
