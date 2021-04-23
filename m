Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF2368DED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbhDWHah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:30:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37123 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbhDWHaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:30:35 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZqGE-0004vd-EA
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 07:29:58 +0000
Received: by mail-wr1-f69.google.com with SMTP id j16-20020adfd2100000b02901022328749eso14718472wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MVzL/AHxddiRwKntK/mYsDPbYNsgKNRIA922iDSZE8k=;
        b=PCi7IhbKBGbrPr8tP2eugN7IeLxvxhl2/CdBA+WXswGoS1M2ia4yDi8kj41o8wIscL
         2CM+8nnsQInth5GZyL/4unIU5Qkwpdfw8TGciZZC2blBdoycQdVfHGnDBG//SxiLsg5Q
         HXlnU/eLfT6uUcq6IQdR+ycMl2VLFnNIa90Fdv9SzyjoIyENQPiQcQbEGtAaTbJTQBOw
         5CzAuNZjePpR+Vl5q1KtDDtFEgSVDAYWS/dkZ/FWadp4w8K94IctbZb4ctKCuyxP0k3m
         Qmw/k2nz+/vRcvkszveuavIbVBQFUa8MDpn93+bvx26LZQdbWqRZzJ29uZsM+v7Z3s1A
         y+dw==
X-Gm-Message-State: AOAM532lBqtMxWVn3ePWVEKXvw5YvOiDZad67ahkqVKQN1oQ+f5U9W2T
        uc2ZddwL8kyYSCJQSslAi4ZifhQndnX1ypRIu0neyjC9N6Pmr/J9Ue+ZiIjZDCyaVTy/sfe32/4
        koHBh80jqn4mHBBTfbGUbaLJJEzgig5pZxyXtUpHXyQ==
X-Received: by 2002:a1c:9853:: with SMTP id a80mr2723049wme.44.1619162998202;
        Fri, 23 Apr 2021 00:29:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS6jXpcG0GbrZ8miHA/kmV9+gUvbNjl2AASXqwOfdmHV0hpK5ThYAbgluezO0qRmGEMZJLVA==
X-Received: by 2002:a1c:9853:: with SMTP id a80mr2723039wme.44.1619162998068;
        Fri, 23 Apr 2021 00:29:58 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id u3sm6662428wmg.48.2021.04.23.00.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:29:57 -0700 (PDT)
Subject: Re: [PATCH 064/190] Revert "nfc: s3fwrn5: replace the assertion with
 a WARN_ON"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-65-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9c2877c3-8077-c2e2-ed0d-80b2a0c87634@canonical.com>
Date:   Fri, 23 Apr 2021 09:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-65-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> This reverts commit 615f22f58029aa747b12768985e7f91cd053daa2.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/nfc/s3fwrn5/firmware.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
> index eb5d7a5beac7..f77f183c9bd0 100644
> --- a/drivers/nfc/s3fwrn5/firmware.c
> +++ b/drivers/nfc/s3fwrn5/firmware.c
> @@ -492,10 +492,7 @@ int s3fwrn5_fw_recv_frame(struct nci_dev *ndev, struct sk_buff *skb)
>  	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
>  	struct s3fwrn5_fw_info *fw_info = &info->fw_info;
>  
> -	if (WARN_ON(fw_info->rsp)) {
> -		kfree_skb(skb);
> -		return -EINVAL;
> -	}
> +	BUG_ON(fw_info->rsp);

It took me some time to understand this but the original commit looks
correct. The recv_frame functions s3fwrn5_recv_frame() or
nci_recv_frame() should free the skb buffer on errors.  Here, the
s3fwrn5_fw_recv_frame() should be called only after sending a FW msg and
is expected to have fw_info->rsp=NULL. Otherwise it could mean that
frame came twice or it came when we did not ask for it.

Original code looks good, please drop the revert.

Best regards,
Krzysztof
