Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC73E9E09
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhHLFmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhHLFmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:42:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05297C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:41:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2143597wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rncRDKB4DU9qhENuipCw4tDszCNGSLCKP5orEvp1cWI=;
        b=dXuFruq7lCDTRNnVaFujcdz0wTyQokilgVy2twiIvH3RT/EhsgHCgpAMPxGy3DPM8d
         JpWr8Ku6CvQsbhTnjNE4ZEubVzgQAWWTxwoeK8bU9tMyaPWDXaTXhDUVpss+LHouDpBh
         im6/q1l6SrocvB82xT1JwjLKJONDM/JY4fXlPX7Q7sokVwdtAHkG/uupeyEmIYOsto2D
         cGSvVMnczI2vBDiVagaQkrUE90qXE4NtUzULP+8+d7IJP2DAXjt04VQP6WADAsAPidPA
         MrUvmoiaUbwWMjJUa8vucJMwvnzlacJpLQe2obSswSSQRKixfPrD6BvUbO6tg29EFhab
         zz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rncRDKB4DU9qhENuipCw4tDszCNGSLCKP5orEvp1cWI=;
        b=F6Mz5rys5jqphgoLBsRmGUlVMvpRgerg3+FYAiOu13E4Qno8/wWCXW1A8QmPvVUY5K
         HDL1Hq1npBAy4LNqxTNxd+bxZyPqy/gFbBjVqWu3W7qybRMLeAyNJ8gbSqMO5JhyaxkM
         BsCsIWdeQFEX1Cqs5EskyjEXqefqQPnZbpIa72Tf+pUTEvlmbZVkZUv2m/9hNeidLXo/
         ovegeD4iahMFYPxmN0UYIq/okCrQvHwfGmI6ZOO0zesBe6TZjIwvRMItWL1lU7sNWMpr
         K8OwdjWq+i1UGYXEDQiMOSUR20c1GWvldSNO2Hrb9qPhdognSaKPDMGg8j0YV+V3jZM0
         rUbQ==
X-Gm-Message-State: AOAM5336SpTOKBMH/acfkR+WQLE3EosUJmzZTppEq5QXJoFzeVdydYze
        zIm3uYtRm/trjVMcAqKvT/yfs8+HhR6/ZFdMBwP1w2O/SNQubQ==
X-Google-Smtp-Source: ABdhPJxseI3t2x/knaEVYGiPdBrwSotqAyWl4kqDtlUxAM2XvSB739HTGblOGjlOI7bw6q/j0b8r1/Qw/YeT9kzjt3Q=
X-Received: by 2002:a1c:5411:: with SMTP id i17mr1932655wmb.183.1628746900232;
 Wed, 11 Aug 2021 22:41:40 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 12 Aug 2021 00:41:29 -0500
Message-ID: <CAH2r5msrRdGmFGht+rN7_UgkmrpT8eaAoQ46EyLvxhm7M-fKmg@mail.gmail.com>
Subject: signed integer overflow in atomic.h
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

===============
[   28.345189] UBSAN: signed-integer-overflow in
./arch/x86/include/asm/atomic.h:165:11
[   28.345196] 484501395 + 2024361625 cannot be represented in type 'int'
[   28.345202] CPU: 6 PID: 987 Comm: nmbd Not tainted 5.11.22 #1
[   28.345208] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   28.345212] Call Trace:
[   28.345218]  dump_stack+0x8d/0xb5
[   28.345233]  ubsan_epilogue+0x5/0x50
[   28.345242]  handle_overflow+0xa3/0xb0
[   28.345257]  ? rcu_read_lock_sched_held+0x39/0x80
[   28.345270]  ip_idents_reserve+0x8d/0xb0
[   28.345283]  __ip_select_ident+0x3f/0x70
[   28.345292]  __ip_make_skb+0x279/0x450
[   28.345302]  ? ip_reply_glue_bits+0x40/0x40
[   28.345314]  ip_make_skb+0x10d/0x130
[   28.345326]  ? ip_route_output_key_hash+0xee/0x190
[   28.345344]  udp_sendmsg+0x79b/0x13b0
[   28.345365]  ? ip_reply_glue_bits+0x40/0x40
[   28.345403]  ? find_held_lock+0x29/0xb0
[   28.345420]  ? sock_sendmsg+0x54/0x60
[   28.345426]  sock_sendmsg+0x54/0x60


-- 
Thanks,

Steve
