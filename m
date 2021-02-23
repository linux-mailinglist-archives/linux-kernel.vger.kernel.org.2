Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13F32340D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhBWW6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhBWWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:42:40 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C803C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:42:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h18so13777ils.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=TSVUM/zT7BA44V6HBXT0zpH7TqCwFdeKGgTUPMw/nr1Y2Nq0B9o4FEK0tmf4Pte/5D
         Tc7YEQdOVlrhymfkLb+TVtGFuV0xBjEtueZLXS6u/+zHlqSEP2cWBDJUyi0gBt9QrEq9
         JzWUETk3pdWvV2ZtiHcwTAiwt5e4ApF6Kyr4elT9rZyOzcaa2SA0BYGpUEqbmLeDOIeY
         4x6i/qvAaTa/hDKKdDrFMWkD7ZtEazBppxAnmI77EhcHQFuoIY2RwZQkO+yf7YcAGlSC
         rEoX5IO49rb3mbSrn0ZX6+ISAvuak+0lGci/nfKDTTUVnOcrqmfie7Vb9xUzdOSkjOz1
         2lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=VxvC24bMvgLixc5mVSacJVsk0bjgbO3JjbQJVeJ5gdDYdxt5DKU/rMiqxEQD5Mu+UX
         AVpQDO0Y4/OuqwB69Ja8fqE4waCs17/TDmy8m28ud6prtnu4dtk3Mif+4A1ry2uXp+r+
         CJLb6W8AeCXmQVqm6uW8Esx5ganphWkzEZmCLoEFEiCp0QLC/RAYCJx7z4X5dwF5XXkZ
         w8hL71uLDQmEh+knGiV2y31NIs2szcZ/zNnRgwgk4Ch0NkVJ3wKOS4jlycVEIUzufyOr
         l5rGsh4XcDdlziTqU1cGrVeDa+pHkni0egCCwzWm60FojNO/aCL17ipaNHGYZCDGgml9
         PdGg==
X-Gm-Message-State: AOAM532NG/luMhq8bJ+uo5fXkRYUq0bO7QfTyuygB2gO9QHRdtkF3rZt
        KOhF+sZhNo7Yz2GnzxK/psv3LQ==
X-Google-Smtp-Source: ABdhPJzXHFoTuq4AHw4FgnneXIbXW0HvdigmHBt1L83UU7hsh+H7lS3Cyu4aIsOx6BRDPOXbXSKn3Q==
X-Received: by 2002:a92:3f12:: with SMTP id m18mr21853729ila.109.1614120119892;
        Tue, 23 Feb 2021 14:41:59 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a14sm26801ilj.39.2021.02.23.14.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 14:41:59 -0800 (PST)
Subject: Re: [REGRESSION] "add a disk_uevent helper" breaks booting Andorid w/
 dynamic partitions
To:     Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, David Anderson <dvander@google.com>,
        linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Alistair Delva <adelva@google.com>
References: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
 <20210223063130.GA16292@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b11afae3-64bb-5ccc-535e-e8c4add4d0f6@kernel.dk>
Date:   Tue, 23 Feb 2021 15:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223063130.GA16292@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

