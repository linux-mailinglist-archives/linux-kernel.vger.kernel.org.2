Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251CE30C28E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhBBOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhBBOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:50:49 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57655C0613D6;
        Tue,  2 Feb 2021 06:50:09 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id g46so5172777ooi.9;
        Tue, 02 Feb 2021 06:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6qp960vzUTWdzQ4vLdRfVd4KbTMA4C69fW5HKutWjI=;
        b=Tps7dfMaJq5GOCyTnOa3wfGG3Cmt2QKIdHwkm4tvhOMtNcmMcgcvP9KLqeRtjZIAEB
         KjocEAXdj+J3k6qbJ0DrIWMQ13TM2nIIay5aT/3aIEWBHSoa2YZLyRXa8leJHAF7kX7F
         hMKvEWhj+y1okSv97VYAg4aYN5KZt4EJfPMBcAFJPcFtwF4kBe2JRI2AU7QL1SmFZh0q
         GR07u8MEqYyZeyyKo5tNATCjlBEva7w+b4FgXQcA6nqC+fexIhuvcWGclhEV6NX43IcG
         jTchwhp7B35gHpuKE66d1qBjtz7zoTSYEceYmw9svGjmn9SZu7v+zq6CL66RHi8X0MIs
         7Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m6qp960vzUTWdzQ4vLdRfVd4KbTMA4C69fW5HKutWjI=;
        b=bKtothzUg+kOI83quMZU5ZthggfV44XT///FDS/oQ/c4seVZ4FkNL4TL56mh02oG2l
         at4xlEBvkX45NAu527DPwup+QrHU0mZOsmix1lBm1e6oLE1SA3uhIO1UMS4+l3KBrKyL
         KynnGqw6OVT41Rs8JJXCbj1R8DLchyonrau9KGhJnAa2itojueRcHpAZhGs9qanA7/wb
         mX8UDtHCds76EcLgxciLyZp1AgEwIYM603ZOiIH2dxvEF0C4O6kp8166mdv+0k4ZUTHy
         PGrXJDIKYSoLxKsrNiykHxQXqrI4Vb/n17DhtLlNoKEZObLYR6mzHPLepS14KaC211Jn
         awlg==
X-Gm-Message-State: AOAM530V8kMGvtl1kF3OCYUUSgR3CNQqv8a7Lu9E0dWUxS9HQ8Nt0nS5
        D4qEwPxaTHQ0naZVsoF6hqfZohnrmWg=
X-Google-Smtp-Source: ABdhPJxEdBjNzP2IOwOE5iDAjCu9fKYl1n22vEWpJsNOCGTIi2ctNYv8cyOT3YCzQgpDxDZLIcU/Hw==
X-Received: by 2002:a4a:52d1:: with SMTP id d200mr15907651oob.64.1612277408252;
        Tue, 02 Feb 2021 06:50:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k198sm5161089oih.33.2021.02.02.06.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:50:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 3/8] usb: pd: Make SVDM Version configurable in VDM
 header
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210202093342.738691-1-kyletso@google.com>
 <20210202093342.738691-4-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <029f8d48-8932-8a2c-4edf-df73d66b21b5@roeck-us.net>
Date:   Tue, 2 Feb 2021 06:50:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202093342.738691-4-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 1:33 AM, Kyle Tso wrote:
> PD Rev 3.0 introduces SVDM Version 2.0. This patch makes the field
> configuable in the header in order to be able to be compatible with
> older SVDM version.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  include/linux/usb/pd_vdo.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index e9b6822c54c2..69ed6929ce6e 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -21,22 +21,24 @@
>   * ----------
>   * <31:16>  :: SVID
>   * <15>     :: VDM type ( 1b == structured, 0b == unstructured )
> - * <14:13>  :: Structured VDM version (can only be 00 == 1.0 currently)
> + * <14:13>  :: Structured VDM version
>   * <12:11>  :: reserved
>   * <10:8>   :: object position (1-7 valid ... used for enter/exit mode only)
>   * <7:6>    :: command type (SVDM only?)
>   * <5>      :: reserved (SVDM), command type (UVDM)
>   * <4:0>    :: command
>   */
> -#define VDO(vid, type, custom)				\
> +#define VDO(vid, type, ver, custom)			\
>  	(((vid) << 16) |				\
>  	 ((type) << 15) |				\
> +	 ((ver) << 13) |				\
>  	 ((custom) & 0x7FFF))
>  

Yu have to fix all users of VDO() as well, or the code will
no longer compile after this patch.

Guenter

>  #define VDO_SVDM_TYPE		(1 << 15)
>  #define VDO_SVDM_VERS(x)	((x) << 13)
>  #define VDO_OPOS(x)		((x) << 8)
>  #define VDO_CMDT(x)		((x) << 6)
> +#define VDO_SVDM_VERS_MASK	VDO_SVDM_VERS(0x3)
>  #define VDO_OPOS_MASK		VDO_OPOS(0x7)
>  #define VDO_CMDT_MASK		VDO_CMDT(0x3)
>  
> @@ -74,6 +76,7 @@
>  
>  #define PD_VDO_VID(vdo)		((vdo) >> 16)
>  #define PD_VDO_SVDM(vdo)	(((vdo) >> 15) & 1)
> +#define PD_VDO_SVDM_VER(vdo)	(((vdo) >> 13) & 0x3)
>  #define PD_VDO_OPOS(vdo)	(((vdo) >> 8) & 0x7)
>  #define PD_VDO_CMD(vdo)		((vdo) & 0x1f)
>  #define PD_VDO_CMDT(vdo)	(((vdo) >> 6) & 0x3)
> 

