Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADBB45C7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbhKXOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352183AbhKXOqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:46:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80063C061397
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 06:16:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m27so7578677lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EtGF4mpY0b2OjlWH8u+f+Rwsq9cIe285UPnj5aIh5kI7/W0UlqTfU6NtM+6U3oUPbL
         zSWjrDsv2oJY8tRuIMgaPk1glK2cTAznvk3ZRf8z+Wkdnb9K9GiZxXpCe+rwMXTZbFUw
         Ee3du/iabjgyATi5Bt7/OE4pChcAPEM+PU82ZLCC6XwfK/pkRMoZ+qPBg4acuLwY0iR4
         ppcKRVtz6HhAGvlo1z83iH9je6sUnt5r2ZlkMbCc6i14OZTMlSxOdbMn/Ab1zvwjzoYV
         CLP3ydCqkABkqq3qmm+3NLKE7Vl+S3z3LcMW7Mon889S0tjXjgJQOsfefAghAbzp148s
         HnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=BORUWlCbdldu67cClU/wEq/OIN5acRuPLPhTmKoXRjqLt3ZtmL3+hs1Jbb1HA/+sOJ
         NXIRys4rHtwKnv6QeIcECNoyvxyZmdp2yt3TCVBH21Y7iJDT7wdaHh1+z37vKQuTpon/
         rtBkmXePHfhkvvFZ2vpBCMpvseoK76jtRW/Z1dBV8oYxmidy/etj0EdFZqDJFJjTLkif
         FYnFibfGXVdCR0Fse8alrNd90JXMiP7znI8/8DgY2H9yKyjOZdZDlhNchBOT15gH7Kys
         tIq0Mezzr06ZzaEq4OsdADLuW76rCyQttj0nGGakNIuoYqhMdm28Z/+bNAM1EXM0s5A4
         UXzA==
X-Gm-Message-State: AOAM533OLdbZPObZME98cPI46XeMfT45Qd3pdV9rw37Z4vCC6xA2BouY
        OBZ5y/c5w1NuxaAmA5Gpzi9mD6PvplRYb1L0tKS9jiAiP31xnpYY
X-Google-Smtp-Source: ABdhPJx6XKOYfrsd41IJZoihe0haQV7sdeTLYclap3VzINGUHZ3NJwzOAYAwIwNHDDSgjUJtqLLszQEZ03cgj80P9Xc=
X-Received: by 2002:ac2:50cd:: with SMTP id h13mr14365942lfm.381.1637761749418;
 Wed, 24 Nov 2021 05:49:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6512:3fc:0:0:0:0 with HTTP; Wed, 24 Nov 2021 05:49:09
 -0800 (PST)
From:   Usman Umar <usmanumar339@gmail.com>
Date:   Wed, 24 Nov 2021 05:49:09 -0800
Message-ID: <CAJHaCci2PdibhWyzAKUqyrLSDpG2Q_XmiGPM-gknvYrY-V1qWg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


