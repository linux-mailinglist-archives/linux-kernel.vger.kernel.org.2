Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5478A41488A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhIVMOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:14:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56588
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234294AbhIVMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:14:40 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5C4CA4025C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632312789;
        bh=hP2w8Q1bmRd7QsbJSWuw/qEx96Jo8lROQWYodGYqF1k=;
        h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type;
        b=qluV3r/7/EaNV5Yb/Re6wvjqVdMCjzZA9he+7erkmkxiVLUZdQ3UNBo8HZDHXiQsM
         mcM7FCxKI+01+fgUYLuWiMJDDIrpwALrw0t4Tgnj5V0lRMeIe9LJYOzYfDmU4pd275
         SwqMetA6rao+Gd9v2JFdl/WGH40jvDaUJ6wKPMh9Zx0LPB7cjlSg7gEHngIaadqzVS
         k5WygabJa5Fj1ZVN5dGVf3x4iskkwlLjDJq7evP9Q9VfkJ2KgxQv8IMkYIbhrzN9U+
         y9xbflMRnMgbYdtCEH+GaHeYkMMjm1dP9Y/p6bCZDTy26Yh/XgI50RRGDDhcSUF9JY
         ppBoa8aVX78lg==
Received: by mail-wr1-f69.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so2027700wrh.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hP2w8Q1bmRd7QsbJSWuw/qEx96Jo8lROQWYodGYqF1k=;
        b=pMmR3H08lA630vcKn9FFltYE8O/OnDhqs9R4kHrPInN+GuyfLnXx6j1oRvzzmJ7cdP
         ReJgxts+IvvCHX670AkS9TKXAr+gmNg4vAGB31w2XNs/CSskJ/VE8ubGKAUjUhAb6TvC
         GkDoGAt7/K1mCIk/bJ4flIqVcSpEZbDcwHNvJM48YHquFC64bTA7t3X2flydFjnmcuco
         074hBC2krXIOhGNi89WuZ/BjXXlQpA5dDBmb9QNBMUodIW4LDfs7PHJuFVbg3lDUYERV
         aiJhikJfM220iVya/n99W9BtdOgCkm8YO6jnjeiFATLvTFznxUSsiHjGyiAZrivTJqnB
         jjVA==
X-Gm-Message-State: AOAM530hayQiumrA9ubvdIdpXDx8RaOfyAJ4cpLt2ovsbRo6e8GACZ0x
        fjGTU3FFbt3VSB2cW1TRmIIdpeAQRPUPCL2mfEBkivvNF+8e36USlRagJtgXPi7WhU8Fw08u8gi
        TeE48kNpwP9jHh+bKmjASZtHr8do1Nwiy2cwZgc5q6Q==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr10228309wmc.85.1632312788942;
        Wed, 22 Sep 2021 05:13:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6RcbWQVWI9dXldtPewpPa4PrqTW+ts4ENjpUypUVVACFIqnLduFSWsT10CZrGiuDO42igJw==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr10228285wmc.85.1632312788799;
        Wed, 22 Sep 2021 05:13:08 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id b188sm1890703wmd.39.2021.09.22.05.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 05:13:08 -0700 (PDT)
To:     linux-nfc@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        aur-general@lists.archlinux.org, devel@lists.fedoraproject.org,
        packaging@lists.opensuse.org
Cc:     Mark Greer <mgreer@animalcreek.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cody P Schafer <dev@codyps.com>,
        Dave Olsthoorn <daveo@fedoraproject.org>,
        Dirk Mueller <dmueller@suse.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [neard] neard release v0.17
Message-ID: <f3701543-8ee0-fefa-c57d-590832a1f951@canonical.com>
Date:   Wed, 22 Sep 2021 14:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

v0.17
=====
After quiet period, the neard user-space counterpart of Linux kernel NFC
stack, gets a new release - v0.17.

The release includes several fixes (including potential security fixes)
and improvements, plus few new features.

Source code release:
https://git.kernel.org/pub/scm/network/nfc/neard.git/tag/?h=v0.17
https://git.kernel.org/pub/scm/network/nfc/neard.git/snapshot/neard-0.17.tar.gz

Few notes on new names and maintainers
======================================
The neard package was previously maintained Samuel Ortiz and Marcel
Holtmann, which were also main contributors. Last years Mark Greer was
looking after neard. I joined in 2021, both as a maintainer of Linux
kernel NFC stack and the neard.

The project development still happens via linux-nfc mailing list but
also got a second home on GitHub:
https://github.com/linux-nfc/neard

Under GitHub I set up also Continuous Integration:
https://github.com/linux-nfc/neard/actions

Feel free join and hack via both channels.

Best regards,
Krzysztof
