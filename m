Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04858313D84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhBHSam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:30:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230395AbhBHQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612800538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2iBB0LyG2KCKP9pDFDKEk0ExuReKwaAb5h/pNk9dGc=;
        b=OO2UnOMOWwN18v8ef4GKqmQ6Q23ms8urDQdfcHAGr+0n7ueKt3H9vpGjaqSh8rATHAUziE
        b9QT2MgnJd7Z273+35OtB6N9qRgKZQViuiKihol0p6IpIMRCpk+nlgHq1BLHe961YYBpuT
        5MgXiTdRqrCYQx0HjV/7zGXcCipsyvM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Fae-9bU0PWqdEkmuyqGiNw-1; Mon, 08 Feb 2021 11:08:57 -0500
X-MC-Unique: Fae-9bU0PWqdEkmuyqGiNw-1
Received: by mail-qv1-f69.google.com with SMTP id h13so10906125qvo.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 08:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P2iBB0LyG2KCKP9pDFDKEk0ExuReKwaAb5h/pNk9dGc=;
        b=IdenWeE/aCGBdjfZEf7fQSDuxyu3LqqFG5D/3/NNimwc5XPFL1XlrfL0p7xwvjqdsr
         pruW7lHESAh+kt4Fyccsf7lk9GeUpRNXG95nn2Er+CkYy2I5ls8EFN9LINVzu+2U6r3f
         dVWe5XUf9LyavCmlLeqbYwIo63YmCdXyT8e++nFsg0R4TABX/M48h3QbaDM4uXNeO7FC
         SE9oVG0iQ1QF1+8+qV3bP6pR84aWVHnxWDm9Lr6edn42eEgfRK+yHTv3M8+eJFLvcj8q
         PZFxdwq/moIqVy7IDXygiptHV0BPxy8pq9ruo0P2pzDWvmpcMaSJ+tLWlKItUjVRiUT/
         McCw==
X-Gm-Message-State: AOAM530JTumakn5Qj7+7gNe9+OS3dE9t4YgZrLPra+ksHHiBEGS1dM1d
        8y3o7b0YAg88JQDFBnZEukIwrJm8Xhf9PKh3nuZnVB/TL2b/9XiGkZIe6r1bMcbytAGVGTYuFSv
        RPEVEohEIcD+MCGpNmGJVsLrYgsc1RBJ1deyKtp6VJ11i2snbQRvQ0LKe9O7pWVnHBLe+lJ0=
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr16979491qvd.22.1612800536491;
        Mon, 08 Feb 2021 08:08:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC7Ey6ojUTMBsmlqkawNby02wq3KpLAqjGFFWc94NaN2MdU5ifFcD7iOTVHLkJhgrKQ/xW0g==
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr16979456qvd.22.1612800536147;
        Mon, 08 Feb 2021 08:08:56 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h5sm14968213qti.22.2021.02.08.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 08:08:55 -0800 (PST)
Subject: Re: [PATCHv2] PCI: Add Silicom Denmark vendor ID
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208150158.2877414-1-mhu@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <904cf9ee-a7a4-d592-c01a-d994f1df9a55@redhat.com>
Date:   Mon, 8 Feb 2021 08:08:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210208150158.2877414-1-mhu@silicom.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/8/21 7:01 AM, Martin Hundebøll wrote:
> Update pci_ids.h with the vendor ID for Silicom Denmark. The define is
> going to be referenced in driver(s) for FPGA accelerated smart NICs.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>
> Changes since v1:
>  * Align commit message/shortlog with similar changes to pci_ids.h
>
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index f968fcda338e..c119f0eb41b6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2589,6 +2589,8 @@
>  
>  #define PCI_VENDOR_ID_REDHAT		0x1b36
>  
> +#define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
> +
>  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
>  
>  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8

