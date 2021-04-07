Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C963564B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346116AbhDGHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:03:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59126 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346051AbhDGHDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:03:22 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU2DY-0000tX-Lp
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 07:03:12 +0000
Received: by mail-ed1-f69.google.com with SMTP id i19so11683321edy.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EPPmWmdaq2dh/UGET3fGHk7TqyifSikdBPPTcaMQ1jg=;
        b=Eaa9jkUcXKg68GYrUp+02Ifid2ribY619Wb3q5h1M1wkA9PtoV+YSBNm2BBmQMaAgT
         tR1XFhfn9H09GnwbyEBnf5NZZ5pW6sVOzPkidHEODOtJCLmwOdtWU+ml+xKKL/ouFWZ4
         fgyOCHJ5oEXhsLxYJwlZdZngGQjDifF6fHQlbEdpGffcBuh9GP1MOBfm81aQDZi9725d
         T59S9hKGmObL9mMvRpl8Tm0sdNVSeRMA5WoTEx78k6MA6ub2nIlIik5M0PAHmRraX+tm
         VYfmhfhP44O+5QTkJebOIWjOVmcQXh2WhTnAyS8fcz0w75wssuAn32HLP6/XNhumuX+E
         lwzg==
X-Gm-Message-State: AOAM530zXY8wuGAx/qRAJ/nVoO2kF+Yt+cNWw2iPxbS5smK5VYW9WKI+
        1/2ahziP8qMuyxvKJNoxoz2h82kKzyio4ku/ZfpN4etAsHvcjQDxx01tnkqS3XXqZWMXP8B9RUh
        WQWWKPFS8wgmKWhokixCwPkNQ66V6zTpYR2ffTEg3WQ==
X-Received: by 2002:a17:907:8315:: with SMTP id mq21mr1978843ejc.197.1617778992223;
        Wed, 07 Apr 2021 00:03:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5unwAu/pheJs7/Bm4+tsoa6su36QNc2QP3KIySluVf5OYxVWePEgyI1T1vZ5SuhSIJMwiOQ==
X-Received: by 2002:a17:907:8315:: with SMTP id mq21mr1978824ejc.197.1617778992048;
        Wed, 07 Apr 2021 00:03:12 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id s9sm14384640edd.16.2021.04.07.00.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 00:03:11 -0700 (PDT)
Subject: Re: [GIT PULL 1/3] ARM: dts: samsung: Pull for v5.13
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210407065828.7213-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <33fb7d93-a091-e1d4-e0e6-463c391b6e76@canonical.com>
Date:   Wed, 7 Apr 2021 09:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407065828.7213-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2021 08:58, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>

I still did not update all my tools for new email - this should be
"From" my Canonical address. The tags are signed with the same key with
@canonical.com UID.  The latest key is already in kernel PGP keyring:
https://korg.docs.kernel.org/pgpkeys.html

Best regards,
Krzysztof
