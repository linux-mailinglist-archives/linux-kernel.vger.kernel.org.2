Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAE03236F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 06:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhBXFij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 00:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhBXFic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 00:38:32 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D36C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:37:52 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o38so738680pgm.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ZdZvefb0yBvG3yGc/kylVRHgR6omvRp6coIcRePrpWFph4hCiLiUsuSCDg8bpChYkt
         g/qn3KERO64/t0D3+P4hFNDeTB1v/xfkXTYqFbDHzST6fe/hoc+ZPPpSsLv678p0hJrt
         qIgnLXo6WHQwj3fbMVAt6h7t6Yhv1ZWMvZNGzm4+DB6faUfvlwE1uo4+H3U+icrY41A1
         4FNwTUq8aze3cm5zk8C8iPu7+EOdHiH7Pzt5KuucbHLpGYKqT8YjCuSFksxnPnMabWj9
         sUciSAC5rDEMwdjKAoLmVI7eOWgpEtA9ybCqaZRO0wioDhZoOCVXBOfLGeKVfuGh2rGT
         sbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=e9PuC13GzMUau+jCPUJ7ABYG5mvvVz9LBqun8ol+j0Nk4kKs57aPifRjweGB464AdX
         dqXSg4ngAKO9yIFeoFSDchMADcG9bwsUlqrw4kYqMEIi8zxJQTrUQ1p1CmG8sCgqKV5w
         kk3A/HPidVfWgQVFy1n3UWG+GnCTJi23PhRK1ln0taZ0HxgPMslk9y7GFwfMSjjf0xKh
         CwavuuVE1Ye3B9L+4EAu91xhFTzCGwKuB3aJ9n/kt8qdUJ019W82eb6MN3bS8rxdfcK6
         PUjRtQNCo1lCyrsoe2M0WKsALCSTNAlOMq2FoozivTt6hyWSxkwhEts1HsKX4BSFNHJK
         v/4A==
X-Gm-Message-State: AOAM530kXjpnN+JUAHqOud/Gwy9nHvTJPeH8SuIyxRXpPYeOx22AS/dR
        t0sVB52Et8bpKnfTQh3wiSP0TOKHF4zT+op1lEdRj6cW
X-Google-Smtp-Source: ABdhPJz0pUt9rcv7TOivztlwzDwpKbFRACgj0ZKYxcSUuPZQG/hnmHRrQHX1goFz3jRB2bM4l/gUTmzX4W86l/X95rs=
X-Received: by 2002:a63:d20d:: with SMTP id a13mr27194259pgg.357.1614145072056;
 Tue, 23 Feb 2021 21:37:52 -0800 (PST)
MIME-Version: 1.0
From:   campion test <campiontest16@gmail.com>
Date:   Wed, 24 Feb 2021 13:37:47 +0800
Message-ID: <CAC14+yjH7SJUdiUe6j52z=6+WW3g8N4Qw048x0KDz-aJsBZrOg@mail.gmail.com>
Subject: this is mail test since the mail also rejected
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


