Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B245F0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354473AbhKZPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378130AbhKZPbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:31:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A8C0613B6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:23:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b40so25104480lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c6UA1L7mibksgWxwi+0e8uoYps7Z0SB9qdqFTSJCfQU=;
        b=Re18SX9KXZX8eS+hxqIbm8TOTNlvusykZlRqE2kawhdFdUXeLXDUF7s4EOkaf1FAx5
         dP9jTUKVesbBCdQuUw66vQ1Xey/qvx5W0BCTr76snoQob2j4jNzMk1icrHmv/Kaue2pl
         f5Xn/OphsMoPK9WDBfx7JIIZjZcEwQjN3rNkIls4TO2h5zzRIBgmRFylZmrzzvv92i9o
         4g3u7cqbF4+BHzqEmOrOOf2SBv2GNA/h0/vq4Ry0pQwgPTCmSSrf4fzAQCmhb6NMt1yz
         kt4Uk4JVewPGFSnxdOia1ufsqofuWlH46s98NSiyD/n5+UrGYaXpjf0kuqyfTsfOymT9
         s0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c6UA1L7mibksgWxwi+0e8uoYps7Z0SB9qdqFTSJCfQU=;
        b=mZGaTZo61tJ14dPXR5VyWf/cRCiw+BsPjmy+0/qqVt1LtJ+5Nv8RE3v5Y8yn4S399+
         XyvWnA4aPq7ciyaxGhOQB2RyIFQEiuacBxX/4JR3WoCdPwsoPViHN+aFeSJGxvBNvXyk
         M0kVq0LRHTNDswG+hgJdw0xBBuMYsH8XbwQnHG29XzF21CrQ5Z+tzwFLoVQAupV8FN9M
         z1DALsI4RiAYh6TJox/wzqKEfK8kQv2jwg/We3DSg9Sc5shBj2PUJg2Nd2eG2w0jgCVA
         DhdOAXeGP6RJQo7kvAq1KLDpkH5evNJbS354VBtQM2+lqHMrepPwTXxNYGVgKJEORo9s
         rx+Q==
X-Gm-Message-State: AOAM530HhiOzgG1BMo99IRctfE9if3WykcLZLXODce/sxKUycBWm/JaD
        E/s0FuhphiWlnY6Ks6TKgejDaYCdZ8A=
X-Google-Smtp-Source: ABdhPJwKgyuJKQGOF56JoY2ClvsXS59QLaQu/YuFHrAvd/c6BapxmYexE/6pO8mv6RWJIM+Aglyf1Q==
X-Received: by 2002:a05:6512:1093:: with SMTP id j19mr30895246lfg.340.1637940213535;
        Fri, 26 Nov 2021 07:23:33 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n3sm520285ljc.92.2021.11.26.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 07:23:33 -0800 (PST)
Subject: Re: [PATCH V3 4/6] xen/unpopulated-alloc: Add mechanism to use Xen
 resource
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
 <1637787223-21129-5-git-send-email-olekstysh@gmail.com>
 <042a46ef-c20f-5cc7-8f9a-75b8731f661f@oracle.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <0a8b74ea-111a-690f-fbe5-ae79b814461e@gmail.com>
Date:   Fri, 26 Nov 2021 17:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <042a46ef-c20f-5cc7-8f9a-75b8731f661f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.11.21 17:17, Boris Ostrovsky wrote:

Hi Boris


>
> On 11/24/21 3:53 PM, Oleksandr Tyshchenko wrote:
>> +    if (target_resource != &iomem_resource) {
>> +        tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
>> +        if (!res) {
>
>
> If (!tmp_res)


Good catch, thank you!


>
>
>> +            ret = -ENOMEM;
>> +            goto err_insert;
>> +        }

-- 
Regards,

Oleksandr Tyshchenko

