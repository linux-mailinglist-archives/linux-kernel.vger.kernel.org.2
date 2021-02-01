Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2230A34B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhBAI3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhBAI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612168060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtjxJNWYFyhtzCOjl9O0jIEw51IuhRGMOel2CdJ1YaA=;
        b=MZvS0WomgWj5uu9kp2DtHNwoBe1+GaCJzB8GpwSnS/dRghF3HzjRioF+efdE2epCVQRfBv
        3yNLO0OnKYiq/qp6LnN8Q3Mnbi5dWjlaHFhdGXw7N8tbCQ8NgTiZNlAxvEjdP+74LpY+pK
        Rc55BjO+ySlkOpfwUCimplz+W6TpcRQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-oBK75PbsP6GG4lXBWvdr2A-1; Mon, 01 Feb 2021 03:27:39 -0500
X-MC-Unique: oBK75PbsP6GG4lXBWvdr2A-1
Received: by mail-ed1-f71.google.com with SMTP id f21so7595104edx.23
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 00:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtjxJNWYFyhtzCOjl9O0jIEw51IuhRGMOel2CdJ1YaA=;
        b=Mb253W81nOafqq8id847VG0WUYxleDB7vjktQ9qmRf+ggCF86m+Bw9hDNT2m6YIxZz
         LddElXnR4vhzxv1D7AZOdGuKF/EjAKaRgtsBpojNmgYeh3l8KSdGBQFLAtormeVE6hcX
         cikd6Ki6NjkpFiBidqycWelIDST0cpT/CqKnWQVnZQlrAM3zpO36lkfX/+NhpFNi1Gqh
         en1+c1ncW2nWSwCDBhtUqaEBa/B4b5HwQbY7/6OxZUXjs0RtX2W+4WBXzBCtvJMpawCH
         494FqkEY1YEnqlBCNlw6q0+5HW08W9aKfHO1/+F7Wc51jBv+XXMsp50ym4TfDRAC2VQa
         3jSA==
X-Gm-Message-State: AOAM531AjhbqHsa/rZpjpm1jJ6VrUqrr/QClYNdXRYvQLMcDV3PV4Uy7
        Qxh/K2oFwPefnKS7B8gYIQ871GC+wRgObrC1YHthoLV1JGDO6FpsJlhkYmrDlnWs8+YNtzQYHZn
        5jScmUYull0+c/HTr816YqtJO
X-Received: by 2002:a17:906:87c3:: with SMTP id zb3mr16696127ejb.244.1612168057816;
        Mon, 01 Feb 2021 00:27:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHPc1RHxFcjF7LwmwUlAN5t4AyU108g/oTEVnrRPYdF3oVKhCSPSPSaQ8D934MYnyg1os+tA==
X-Received: by 2002:a17:906:87c3:: with SMTP id zb3mr16696118ejb.244.1612168057708;
        Mon, 01 Feb 2021 00:27:37 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id g16sm274365ejo.107.2021.02.01.00.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 00:27:37 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
To:     Perry Yuan <perry979106@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20210129172654.2326751-1-mario.limonciello@dell.com>
 <0da9ca30-53b1-8d34-4fc7-62edb6423b26@redhat.com>
 <SA1PR19MB49263EE7ECF0D06962BE00ECFAB79@SA1PR19MB4926.namprd19.prod.outlook.com>
 <a371c1c9-d803-f2e6-dfca-607a0650345f@redhat.com>
 <8c51e60a-f5be-610a-ab13-84223d291a45@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d47f3a1f-e00d-469b-a8fe-3b9fd5f65fe3@redhat.com>
Date:   Mon, 1 Feb 2021 09:27:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8c51e60a-f5be-610a-ab13-84223d291a45@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/21 3:36 AM, Perry Yuan wrote:

<snip>

> Hi Hans.
> Could you share your the commit link after you apply this patch to your for-next branch?

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=64b0efa18f8c3b1baac369b8d74d0fdae02bc4bc

Regards,

Hans

