Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E6330A7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhCHJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhCHJsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:48:35 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87464C06174A;
        Mon,  8 Mar 2021 01:48:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p21so19960846lfu.11;
        Mon, 08 Mar 2021 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yMPvvaC1VpKQ+IQEg4AP1RTQAfaMhDgcAf2MjnMXhso=;
        b=XKrsvsrYEOZlVjswIB+hcBruPgK5CRnwqeWBTzS5AXVZ8iFrdMP5ahzdhj6Lu54U6s
         PF0d4b+fzSRL8xUVrvsyCkVvOqlPFp6UUdww9zA9g2PnnxsIZOmeVwaDPB8sYCBtbhSw
         ns4O66xw/oNspASfX5f4jYLD4WVVjjrN2or2kbO6Z5s0X0ptW2yt/sEahtE+VHPrkAC8
         Qjpr5cN9r2uWGI36QSJhTlta8Zs9IjrDLGBwE5jDmhyMP/ryNqURTXX5+pg1NVjRwwP3
         3bcz+6pXUbVBKN9ij95vJ/WV/hIPd30pv23K+ILFlpDqdMx7Ee75TcUHkM9xTwfpDyJL
         jFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yMPvvaC1VpKQ+IQEg4AP1RTQAfaMhDgcAf2MjnMXhso=;
        b=nm0P3YPehI3mrnsnQ3G94TNthlFbDwIi9wCt6DiXD0zgxMzf4QShWYRev3LAcFTWIh
         ZMsa6ACSXFcInDmrfj384f2GDmQHEj5Mn2jmjZJv7ou6NfSRidas+gYgju/j6WlYtB+V
         5KGmPilbIJrBESilf3qN1VqwrLY5/iAlY/daLofTkE2MAt8gVv02cs7I8nDoZSzypfmn
         0QZjxCiBBuIiyhi7ORqTqcnUF2ZuFUFh+usjbXVhDf8TYLgEvLt8gYtYAVkfZJzQ1V90
         s4uonRd2UPKAj3lb/FuUNsQ/eFqITfO0PhyogAreqT4sbU1mf7h4ZI+eQAKA6BIBBvoN
         Hwfw==
X-Gm-Message-State: AOAM533cDxxv9vT74dkjJUdna36yGPjAo1mJ1tIj3Bm5EnxR9G47zA3k
        0924I7zI5j2cq0HT6Tp3jeQ=
X-Google-Smtp-Source: ABdhPJxzpWbGWi4U0nZEVpAIZqLD56P7BXiW9bEVNlH8CrOYd48qYmJL+wwls6N6OqVRNzfDSyR4TQ==
X-Received: by 2002:a19:6109:: with SMTP id v9mr14344228lfb.546.1615196914072;
        Mon, 08 Mar 2021 01:48:34 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id m3sm1331901lfo.190.2021.03.08.01.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 01:48:33 -0800 (PST)
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: Document use of nvmem-partitions
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-4-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <ee596471-db9b-43e4-c085-9bd938101587@gmail.com>
Date:   Mon, 8 Mar 2021 10:48:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210216212638.28382-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.2021 22:26, Ansuel Smith wrote:
> Document nvmem-partitions compatible used to treat mtd partitions as a
> nvmem provider.

I'm just wondering if "nvmem-partitions" is accurate enough. Partitions
bit sounds a bit ambiguous in the mtd context.

What do you think about "mtd-nvmem-cells" or just "nvmem-cells"?
