Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378DC3E4138
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhHIH67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhHIH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:58:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF2C0613D3;
        Mon,  9 Aug 2021 00:58:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g13so32062032lfj.12;
        Mon, 09 Aug 2021 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FDmayj9MsQZysMROrMQgY1uIkaotHyG2RR1Xax2u5P0=;
        b=dGECYCAe60SEi43dc3/+8Pah+Y0sJJYss3VH16DeLui2aKuQxIDDZ49Im6HIW0EGR7
         +y3wjbT9FjgLcHL7UbcQV7bvY2nqyab+Dqhk6hdsVQY5UN2xz+BECZbKp5WNQVNQnlon
         dE2lWodKV5DxOjjzQ78Yl8B3yuX+ziR5H/+ACLQHEV8sJOtlBV3mVfulRD1L+KJd8dY+
         OtVMfVR0aBtgJCtwNXcYDB5NryzBsq1mfzN3aSX2T9OEAkjDmwfuzjJ/F2ApRkkI1bLM
         3FMQzTrgiXpCafSdDInl7EJqo9T8KD6c0GeutpuSwrtU7wKsSX5xB9VPg5zfV/IA7zNl
         qcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FDmayj9MsQZysMROrMQgY1uIkaotHyG2RR1Xax2u5P0=;
        b=GMQvjWd9PVg9kpq9Bl0KqHp5bTFSb/LkVH9NCTTA6+W3wwvzsdNs5Ll8gnorUT1OSc
         Uvd6N4fT8YLJSZmIArX2UHzpeF0C+lQcDuR8dapuH7vVQWAaCb5m1/ZekLiZetdMDknm
         3WHxvoJ93o8D/2WU1SngYygglEGByeTZGRamQuFoNsqiBYjTPEGhO19YiFkEuZCbtIUb
         2ayKdQ8Ujq3SCFCOUwquc7yDzBwmGNVMWspaE9iy12rwrsdo5HxySoa+/JOyPX2RPlkS
         BpOv8untaTIpVI2O+1AVB7RviSuglZNg4GuMM8TUWdMYVJYBMnHyB7RxzKFPnM1pDocV
         G4/g==
X-Gm-Message-State: AOAM530Ak8iL1F5yy2sruQPEkr/XXBKZdpslNwBmqQIyVz/78Qk2GoM2
        4Xd4cunscp6ayD1IAdOuA/PQh+jBCW5noWWI31To2m7R9aw=
X-Google-Smtp-Source: ABdhPJx7z6skN2zesJRMCNIIL+4iSrI6C5cDeRkQLPFhD0h4ZUEbMA+k0JyUYNNkuzES5dYkC2jocb7Zn4KXyeVVMmE=
X-Received: by 2002:a05:6512:39c6:: with SMTP id k6mr16557377lfu.549.1628495914651;
 Mon, 09 Aug 2021 00:58:34 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Mon, 9 Aug 2021 13:28:23 +0530
Message-ID: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
Subject: read() via USB bus
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

PCIe memory mapped registers can be read via readb(), readw(), readl()
kernel API's. Similarly what are the kernel API to read the device
registers via USB bus

-- 
Thanks,
Sekhar
