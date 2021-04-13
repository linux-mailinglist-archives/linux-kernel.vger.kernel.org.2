Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B435DB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbhDMJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbhDMJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:31:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96739C061574;
        Tue, 13 Apr 2021 02:30:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x13so16140325lfr.2;
        Tue, 13 Apr 2021 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s7QZvPTeYxY+yj8nBXFERhvOKZl4KW+WbFKRapSB+Gk=;
        b=KUGgQjqN6OqzSybB2EqFkEX52UuMFW3WngbAnP7wv9ejk064nD1ccqX4tMz2jJzKjU
         rpU9+inYXIj+kkrspDy55Sh9ZU0DwbfFE3dSZkm8YCLRkM24S60KiBeIbdZpdHwqvVAf
         MlLAAPfxVQzaDJPVXYBWHK0CDaUiJEdcr7UwTZ7wtEE+J8GSUZLrAorbOrJ/MBaZuJZN
         l+k6PwGQ2gvpkuCYMI0sj748QoYmnuHvcOWsVfnilb5eZHeVFGAghmD5hwp4n7hC6Tm+
         cvss4G1HIDL8HCUGIbpFEHKjA+8KCTMopRybzuWjx7Tsc9RQpo6BJGakTJoZErXfqoS7
         +J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s7QZvPTeYxY+yj8nBXFERhvOKZl4KW+WbFKRapSB+Gk=;
        b=kv2KXGRinbCLTqzdEOWE/TtomBNTJC8uodXPtp4zPgcejvZ6jQqzVuN8vUzP5k+BGa
         Ts7izE2arjzaE7/pIogj9WoWpObxlDZ4WpEtww9IvQzxVHMc1v4Sj7SDBAENGlVeOMYc
         05yNqTcYNTipWv5ivIN0lL6gQdmQGVpL7/gT44mJymci+5SpNNWp/f05GvXjeJSedNoD
         aGE9RSW9JBUKjjfk6z9+PwxvUVxiqHx0dQmWL95va5m3Z8XPWYr2aQkXi9Jd4pYPXsUx
         Hpflv7LQvzwNWyGiTTp1vbxQkaK5PZqVZD2xfdOkUdPr1VaGbkuOwR/A5jvQIeFRNIkd
         GdXw==
X-Gm-Message-State: AOAM532jpzmNg50CdYia9Pni92auQb3q1Or0rOlCJL0O2HqXd/cArMKo
        srAhacHKFxOCDBUGll6oOBY=
X-Google-Smtp-Source: ABdhPJz5SANHlCPPwZiXcvRHqQe7w8fxkTpOZfO2ibmZFca7MVnO2o4zMf3rTDtqpyTfRURy9IjM8Q==
X-Received: by 2002:a19:7d02:: with SMTP id y2mr23649086lfc.187.1618306254698;
        Tue, 13 Apr 2021 02:30:54 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.76.152])
        by smtp.gmail.com with ESMTPSA id z22sm2474030lfu.112.2021.04.13.02.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 02:30:54 -0700 (PDT)
Subject: Re: [PATCH v2 11/12] usb: dwc2: Add clock gating exiting flow by
 system resume
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <20210413073723.BA0FEA022E@mailhost.synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <2062887e-f1c6-a79c-8af1-31852a7f877f@gmail.com>
Date:   Tue, 13 Apr 2021 12:30:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413073723.BA0FEA022E@mailhost.synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2021 10:37, Artur Petrosyan wrote:

> If not hibernation nor partial power down are supported,

    s/not/neither/?

> port resume is done using the clock gating programming flow.
> 
> Adds a new flow of exiting clock gating when PC is
> resumed.
> 
> Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
> ---
>   Changes in v2:
>   - None
> 
>   drivers/usb/dwc2/hcd.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 09dcd37b9ef8..04a1b53d65af 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -4445,6 +4445,28 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
>   		break;
>   	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
>   	case DWC2_POWER_DOWN_PARAM_NONE:
> +		/*
> +		 * If not hibernation nor partial power down are supported,

    s/not/neither/?

[...]

MBR, Sergei
