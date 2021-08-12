Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0B3E9F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhHLHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234182AbhHLHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628754024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YA80MSfyY5cO2eHQcFvJZUr+QFbT8jyLIwVnL3XyDE=;
        b=aErHlgIO8+WFoZTPW8680TtfjwzxaWi6iH4JQew/RHRPqh7bx+AdV9jVcITUdZnf1eiZe3
        HM0uLo1RmijLZRmNDZFQ0RUT+EsZP+IjOTMonI3yQVIG0PQQrEMJ0OBKDJ1DxFAbwD7bKR
        KavXM5G0/UZADnvSew9+8LsvOkk811M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-wBYUyVlLPXqo8BhimmiKdw-1; Thu, 12 Aug 2021 03:40:23 -0400
X-MC-Unique: wBYUyVlLPXqo8BhimmiKdw-1
Received: by mail-ed1-f69.google.com with SMTP id g3-20020a0564024243b02903be33db5ae6so2631353edb.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+YA80MSfyY5cO2eHQcFvJZUr+QFbT8jyLIwVnL3XyDE=;
        b=FswLX2cPzLNorZCGEKoq5uElDI/s7wUI2hlC3DSYi4bHohRX8hBQ6r435Qpxsl/beW
         wbTUUf6xnb6S+c3OFXVGj+PFpemoFj545lpjkV0sMp9LjFbeTzNncT5+GCYtcYGp6328
         81ewzlOGgrqB9ppQcgKa49u0Zo03YWKWULGIbXbRT9URIpmtvw7YnWdOdSNLVoKz4Af1
         gLgOVAES0ouJ0Wit3/pIY5ppe8sAq+DIjT4kpJBDbacvhtqQ3HKGEvrZbNHR46H23+6Z
         q16fzx/FVat88zargcYF+f4QpwPYGOZrejPhg4+k0kZO2BFgC2YBB28Vi4Xn1wNCYCcz
         IVjA==
X-Gm-Message-State: AOAM530IFQpyRge5HtKDJXpXhYh6+BTSJt6mC6qsYmil+75vc+7LjGqk
        Y5vvLHKKSQ/Mr1NtNB7khorFfOmhLS6vmOGyaH5lkobHiYCN1Jk30NJNjkzO3sTxxZHuGEKOBYD
        dUG7kliRpS+R5z0NPMfGCKusN
X-Received: by 2002:a17:907:3e05:: with SMTP id hp5mr2332446ejc.527.1628754022300;
        Thu, 12 Aug 2021 00:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHLttD6vImBlvWaz8Zn8JlOuh1AiQvwTB4Xn2HZ+O0TYRrJEkwE12etpyy/cqh8wA5osMDCw==
X-Received: by 2002:a17:907:3e05:: with SMTP id hp5mr2332436ejc.527.1628754022136;
        Thu, 12 Aug 2021 00:40:22 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id um4sm490085ejb.92.2021.08.12.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 00:40:21 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <mark.gross@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210811081619.3d3434cb@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1cb8dd94-a71b-aa91-3bed-365ce081dfd6@redhat.com>
Date:   Thu, 12 Aug 2021 09:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811081619.3d3434cb@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/21 12:16 AM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   5c62c3d98b87 ("platform/x86: ISST: Fix optimization with use of numa")
> 
> Fixes tag
> 
>   Fixes: aa2ddd242572 ("ISST: Use numa node id for cpu pci dev mapping")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'

Thanks, I've fixes this now and then a forced-push of the pdx86 for-next branch.

Question, is there some script which I can run on my own tree to catch
this (and similar issues) myself?  checkpatch does not catch this problem.

Regards,

Hans

