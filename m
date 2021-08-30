Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2B3FB2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhH3Ivf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhH3Ive (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:51:34 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C40C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:50:40 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v28-20020a05622a189cb029028e697f617dso650844qtc.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WCe88g7AXY9JlaaNfnczI9r0A/F6aA5ScCXXL8MQTbQ=;
        b=bcC1OCRPm6wMd+6jhTq5ndmFY5wYcgLdbW9cCRTjWXi5sudLNVoDbGbmszS5ZJzTN4
         P0Ttlmvrboav75fyWkQqJYv2RBsugznVtD0AmQyuRkwBG639Nx+E6mc6Iw58gbiMOPtD
         9BIiZ8c+jRspSH1ARtAAGZTVHNneDAHl0EI+ke3SsptCcCho47mUs9ZXjsvBDskZ4BfR
         ItS6VqxraY77c2an8hw0OFxOZl4bR1JXBl2QOk7pcGIm0NDHNhR7ESUA+93ZgCW7/UNd
         PcJr4puGjLk3Umkn1OaYgzmMwOP7p0w51zB4IbF7G/m3crrgWYE6DtZNeGmkfQ8H86Fh
         7xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WCe88g7AXY9JlaaNfnczI9r0A/F6aA5ScCXXL8MQTbQ=;
        b=sLBDAUts3+cc1NL9cZd64gMgMbfB+frRLHzCddFxJovAS57pYCNQhZvLf4zvUXzUlD
         2oIjd2GmzfbxwZKiI5OhwCyEKG6TkvF9ZvMMn+5Md8q6RMs9kBXEMeoZWtJP3dHS9e19
         viXKSHW2WBFPN/+kHAQQz6EZ1XYHYhayoKrRkgP5gfxVYKwjDYkqy1zpbgdK/xSU/UPt
         6CgTyLTrTJY99x6tF8qv58BjnD6YzgmeoZWv967/E2FQgyQ16/YBJ6dzBj/ZjUFxkaJp
         Mh+RzlXusiZXftNgi0rTVKxdGhkiSUrL9fWxP4bX3pF6WYLz0qv97yLydQvDZT3nk7oo
         dLTA==
X-Gm-Message-State: AOAM533QS+ompitekTO4Y7rzxb+S4pJGHIeucAPph3kk3qZgcExoxt9R
        qBS94IZ473fOryE3SRnkS2ev44EHxnJH
X-Google-Smtp-Source: ABdhPJyd0GkGZ8FrrElrpCEdvAxN+QB+fxbOK8cNw07FbgGyQIOqvJXhwzj0C3etAbfFwqnahiDpkz8hp48f
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:7e54:6e42:f267:120d])
 (user=dvyukov job=sendgmr) by 2002:a05:6214:104e:: with SMTP id
 l14mr21749227qvr.45.1630313440139; Mon, 30 Aug 2021 01:50:40 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:50:35 +0200
In-Reply-To: <000000000000b6599705ca78de28@google.com>
Message-Id: <20210830085035.2763839-1-dvyukov@google.com>
Mime-Version: 1.0
References: <000000000000b6599705ca78de28@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [syzbot] BUG: please report to dccp@vger.kernel.org => prev = NUM,
 last = NUM at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx
From:   Dmitry Vyukov <dvyukov@google.com>
To:     syzbot+d9bd66f8d352f7eb1955@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        dccp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same as:

#syz dup: BUG: please report to dccp@vger.kernel.org => prev = 0, last = 0 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_hist_sample_rtt()

https://syzkaller.appspot.com/bug?id=0881c535c265ca965edc49c0ac3d0a9850d26eb1
