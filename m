Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46A032BC8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359318AbhCCOLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842928AbhCCKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:38 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0FDC08ECB6;
        Wed,  3 Mar 2021 02:01:59 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id r25so26862691ljk.11;
        Wed, 03 Mar 2021 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R4yEHlzB6XakeQQlTZxRAo9qsHcvOqzKmknFOqHVxhg=;
        b=WM5bTyUWPgFDTCMoyzsX+KfFqy5aBZ38DajaFdPzPPACOQ9o5BhXM8Jq/hmMj43zrg
         JFz9SivTYI3Bjwpvmtsaj2/baGwYPHbv9+29nDnmbEEgESo0JhChSE3jEawx4k0zgGBY
         Jm66x9cMJSF5V7zz4bg5ZAJhOx859qwAa0jp5lnwXbwhVsR5TXKT5469R6UlXGN5fsk4
         36l9wF/G4OD1DZPG62737/Pzj35ZXTFyfdrag3yYZeM5g66Y+LHf+2Paq04a5BnWxrX8
         GFDhzchNg2JS+9nQsbIQyFKSJcx+z9LAhA8ajN7GwUYNZHi3dUac/eD6jPybKc9mLUKr
         ywMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4yEHlzB6XakeQQlTZxRAo9qsHcvOqzKmknFOqHVxhg=;
        b=R1tkWXbwBkR+E03p7lioSF1ZMCDMC6cI8GvFAsZvzXUL4WELKyOtpgRUjLLuvfgRaV
         ZpISulIK9d/d67/60gppLB65tfcbZYQh/3M2aNdyqf6lHb5CSbTVGLK6xDVkpnBmfQMv
         Yv03C3lGCiTScuKbtEGKJNcTK5SUFWs7A2uqyW79VfYrL0tNB8LJHtDXT9kvkZntAiKL
         XG0t1UlZQul2Fb9KltmSFMkn+zxZ43qIz/nuUBXbfV+/7UhU/X+FqXf5fSkwRX0Wy+hM
         aCEqc+Jgd+VWk37OQj++lnGny7iztS0pVVFYkYkq+8XdFlwY3JGF3YU/AhktzwKWIHIi
         N/LA==
X-Gm-Message-State: AOAM532brizb4BITvLOd8WUAuM2T4NHuegulrPEPg5fZRpZ3hvQZq9ob
        OAQ+yrb94i0tWiXHFX1TqnA=
X-Google-Smtp-Source: ABdhPJxqQtEaXE3/ZVnzSGme5zK+ZqPP28+Lj7UKmvdAihdZ9pYMgPUc58nF2LXueOWSWp1NfRz1qQ==
X-Received: by 2002:a2e:b8c5:: with SMTP id s5mr14271804ljp.335.1614765718140;
        Wed, 03 Mar 2021 02:01:58 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id z7sm742814ljn.93.2021.03.03.02.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 02:01:57 -0800 (PST)
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: Document use of nvmem-partitions
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-4-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <1cf374f1-09d5-9fa9-9b0d-d8079f2f6fbc@gmail.com>
Date:   Wed, 3 Mar 2021 11:01:55 +0100
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

[Rob: please advise]

On 16.02.2021 22:26, Ansuel Smith wrote:
> Document nvmem-partitions compatible used to treat mtd partitions as a
> nvmem provider.

Until now we were using "compatible" string in partition node only for
parsers (looking for subpartitions). We need to think if this change can
break anything from DT / Linux perspective.

Compatible strings should be unique, so there is no risk of conflict
between NVMEM and parsers.

Now: can we ever need mtd partition to:
1. Contain subpartitions
2. Provide NVMEM
at the same time?

Let's say:

partition@0 {
	compatible = "vendor,dynamic-firmware-partitions", "nvmem-partitions";
	label = "firmware";
	reg = <0x0 0x100000>;
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0x0 0x100000>;

	firmware-version@10 {
		reg = <0x10 0x4>;
	};

	firmware-date@10 {
		reg = <0x20 0x4>;
	};
};

Is that allowed to respect both "compatible" strings and have:
1. Linux parser parse "firmware" for subpartitions
2. Linux MTD register "firmware" as NVMEM device
?

If not, what other options do we have? Is that allowed to have a
dangling MTD NVMEM node with phandle to MTD partition?

firmware: partition@0 {
	compatible = "vendor,dynamic-firmware-partitions";
	label = "firmware";
	reg = <0x0 0x100000>;
};

(...)

firmware-version@10 {
	compatible = "mtd-nvmem";
	reg = <0x10 0x4>;
	mtd = <&firmware>;
};

firmware-date@10 {
	compatible = "mtd-nvmem";
	reg = <0x20 0x4>;
	mtd = <&firmware>;
};


Rob: I'd really appreciate your input & help here.
