Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A959E339008
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhCLO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhCLO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:28:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A390C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:28:53 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n14so25936994iog.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/fiZTQtq9gTeTOjOSp4jyAv3E49NXWqKgxF4Ys8Usr4=;
        b=PgJtrn3JkigDnDD0ot0BbvuTVDrk5Lepcl8hTKF3jWiagWQxwxsceDj36pIquQPQ8X
         u/PGP2RRMFeeICcZ6S8qP3TdzvbGb1m/npFKCk1xFU5+cBovfKn1LiXJ66ODJZz7dnpg
         mJw8oFWKr75opaIQcb/JuhsBT5/fNf2PpK/Ant9yDt38S6caFC1rpgCaoMyaIqbIDKZn
         bxP0bddKF+BJUvHuYRFAXhWN28I++8N3A4ppYjTPrCjMrkJ11/EO+vM4i547t1oxw5Pq
         bei2y8Cm6VU8e2Cta9U+NT8INCE7mONklBzBn5Yscz4g+K4kDHdxwMHh3kb6Zg54FDGW
         iAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/fiZTQtq9gTeTOjOSp4jyAv3E49NXWqKgxF4Ys8Usr4=;
        b=RTVaWs0o0t7eaI8Fg7hEkFXpo9/h7WjrQAj7/GxrO4UK3xjO08XVGUrmIEz3EZr00w
         aRL+717WVb5rbisPAua9CzkfZKhmNbdUHZPc3vFLdPJLsEpusBlR2+DZbLiiLTVbghw2
         PXe2zhY0DkMDYVrgqnCiZI/8c8XtON6pZWhqhm5uDyEtvZXpIKTDfcHHDIenqdM+ccqg
         dRpiqMulF0xGKeTiwYznwZctC52fVXpXkCEBAaJuGqB4nZvwCoCn86saK4z5m66eCjPL
         HLDR5OOc7qam9CIoOWJjKb4gM6L2qZfkLjDPtnjZ3JFUeHYf6LU7thsEi8Qf9S4SLFWO
         JT4w==
X-Gm-Message-State: AOAM533692PMerhsl+OZWZuEs98JL9KZbZ+5uzk6vSWdEFX9TOJ4QMgK
        aqjexRjhi+B/yaz2dM7oFL9Asw==
X-Google-Smtp-Source: ABdhPJzHEHp2ymeNqkXcdjnzjDXZiTHChh+B+IS1iFuYGH/vKFf+b1FIO7ooqyN87D4H2n6FzQFZtQ==
X-Received: by 2002:a5e:840a:: with SMTP id h10mr10261346ioj.206.1615559332769;
        Fri, 12 Mar 2021 06:28:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f3sm2985001ilk.74.2021.03.12.06.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 06:28:52 -0800 (PST)
Subject: Re: [PATCH] ata: Trivial spelling fixes in the file pata_ns87415.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210312085738.9372-1-unixbhaskar@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5cc49738-0778-1574-2f4b-9bd179436e8e@kernel.dk>
Date:   Fri, 12 Mar 2021 07:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312085738.9372-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 1:57 AM, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes.

Applied, thanks.

-- 
Jens Axboe

