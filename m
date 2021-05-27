Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B42392E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhE0Mmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235570AbhE0Mmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:42:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85C20613C3;
        Thu, 27 May 2021 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622119271;
        bh=5WxsA1WAO6tWgWz77ekv//DLaN/lDLlPxwS1g7L8DV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIllHRqYVM+slgMU4SL3IyyU0GALZO55e/NgBDhpeWvUQpHcFG0wW2kOY+u6s+5rl
         /vlIjo7SW+ARvpPWQs7kvYJpOaLMAfDv2+2PDwnIkdd1h464SjPXyDF7sHLnvQBzXu
         u6fQ8zOn422LuLCVpDcUrvCOLpvENu1OeuzxOt0M=
Date:   Thu, 27 May 2021 14:41:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        badhri@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: connector: Replace BIT macro with
 generic bit ops
Message-ID: <YK+TZOAlc6zYRE0v@kroah.com>
References: <20210527121029.583611-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527121029.583611-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 08:10:29PM +0800, Kyle Tso wrote:
> BIT macro is not defined. Replace it with generic bit operations.
> 
> Fixes: 630dce2810b9 ("dt-bindings: connector: Add SVDM VDO properties")
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> Changes since v1:
> - re-word the commit message
> 
>  include/dt-bindings/usb/pd.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> index fef3ef65967f..cb70b4ceedde 100644
> --- a/include/dt-bindings/usb/pd.h
> +++ b/include/dt-bindings/usb/pd.h
> @@ -163,10 +163,10 @@
>  #define UFP_VDO_VER1_2		2
>  
>  /* Device Capability */
> -#define DEV_USB2_CAPABLE	BIT(0)
> -#define DEV_USB2_BILLBOARD	BIT(1)
> -#define DEV_USB3_CAPABLE	BIT(2)
> -#define DEV_USB4_CAPABLE	BIT(3)
> +#define DEV_USB2_CAPABLE	(1 << 0)
> +#define DEV_USB2_BILLBOARD	(1 << 1)
> +#define DEV_USB3_CAPABLE	(1 << 2)
> +#define DEV_USB4_CAPABLE	(1 << 3)

Why not just include the proper .h file instead?
