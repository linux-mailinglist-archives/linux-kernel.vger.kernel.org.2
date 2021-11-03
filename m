Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0744442DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhKCN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhKCN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:57:55 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AAC06120A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 06:55:19 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id n201so1312960vkn.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BIBU46l1X4EwQGFNfXRnUTP6JKa422SvOBpzzqZthog=;
        b=ccvFPk0HY7WXd3E0LaSWzOCZw5FpF4kAJaj2lAlnD6hZaKMq2/gX+NHOcGBcMJUQrb
         BEE2d8ipLuZESHBkZ9agAJOrZsBbFU+Oe0HVGJMQ0u5NZ519uOpgb8vg65UzNh97TTQ/
         rUga1bFx3oKQVTNFry2H1vei4Cdo6L6QCKf9FvzSNHOlJuBtmxc4d3iJlMc9Ft7oclsm
         c3z3G0iZ/1WG3EmcDv/ABj2BMzRe8doE0YwJYfG9G6NK9krObqhcMql6AjKqOy5pejpC
         M8+0nmT1Ki02Fvel9chcs1FrMJT88rt5SEW+JzxkKxxWK0ed8pqx0NyYN6cu3suv2M3O
         VskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=BIBU46l1X4EwQGFNfXRnUTP6JKa422SvOBpzzqZthog=;
        b=pvkR7iMrTSgbOK7azheNHv/wa9rYN1EprAFvU3kZ7ShlQG9yu2OljLssagC2PspE+e
         5xFx5dx89IRzjIL+8r2WUHKfLgLFev6inS1OhvhdbWb/qN/KKSp3qJHZLoQAEU//q/37
         6a4NYbLIp2CSuahgxtYTGs+mjn8WDzK9vp7PEIbfmWz0iS3VJBgf55a/QvX4T5bgfbEW
         90FqK+yRl5+0wbe6GD9dOPJEjZ4I2zWtJE5Zvev5FVURr37LLYrO65IwPpJLTTMB3lxy
         TpjyFPNWLIiHiz01WXSEBvh16I5uhflgViGWLPb74jR2ldl2cLhFQjyR8NtdHKBYgS23
         ddNg==
X-Gm-Message-State: AOAM533n6AXe5SQfK6mTgPYrQAzw1i+Fj7YSArCgKoUU5OMeIUvq8d0x
        IqFpBAkQVyi8m0q3I/7Je8X0hlYMhPztNBMBwWk=
X-Google-Smtp-Source: ABdhPJy5WXRxf+e8hyFdgU1UcXFt3+INInqDy6IwXcgTyd7u9uusXioUOyf71teQ6WPmmSwgldYCaXUR+WEGS8YUg44=
X-Received: by 2002:a05:6122:208c:: with SMTP id i12mr21582395vkd.5.1635947718303;
 Wed, 03 Nov 2021 06:55:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:bf0e:0:b0:23d:5e9c:3616 with HTTP; Wed, 3 Nov 2021
 06:55:17 -0700 (PDT)
Reply-To: imfofficeuk5@gmail.com
From:   imf office uk <todhl557@gmail.com>
Date:   Wed, 3 Nov 2021 06:55:17 -0700
Message-ID: <CALpTTE_4M4N21Cbip3qX28hpWjF5jpDVJUCPKCeLqziL68kVZQ@mail.gmail.com>
Subject: HI
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5YaN5pyD77yMDQroq4vllY/miJHlj6/ku6XlkozkvaDoq4foq4fll44NCuWVj+WAme+8jA0KDQoN
Ckdvb2QgZGF5LA0KUGxlYXNlIGNhbiBpIHRhbGsgdG8geW91DQpSZWdhcmRzLA0K
