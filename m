Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06DF38BCD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbhEUDHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhEUDHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:07:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6DFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:06:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id v4so14405090qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=LpMq9CF8MzjnTjzeP8/EpsuR654S/kSJPWNCceaUKB4=;
        b=CFbXOs4TKYij7Z0rI07MdXIn9+e/f1E/PDWQ7U+ELffftBYVvoK2xJlHWKdUA5t4s+
         43H7KYO1a5Swtfb7BQXH7dhRIb01a2hm2Exwf2K2P1FcITyISrR6CVJ2j/jI+n+AryF2
         PnL+Y1Vj2yY/aTnRyS3pIJDMidZPzgzttxRwwZ0Ny3QMQbD4cUaPwnEy4Jsgf1U+M/P6
         NCP+cdjX968v6w3nF4MEGS1XJsC/vK7FL0ijgvB4mlYnqgxXyBiGjOtLa0QlnB0vPROc
         A2RXJTmKAv27io6vUknGp6oohdSROk3sU4xcJdM8oqc3ycWneuEpOJz/nss2FGM2Pl4Q
         vtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=LpMq9CF8MzjnTjzeP8/EpsuR654S/kSJPWNCceaUKB4=;
        b=cifqfMQQzBAWrN7JEpjec7ZE3LQa1ZH4jKRw89EpEDvR7KnmwOpCH1nj9JvHws6Rlk
         NM8oEpK0EWANroOUnxAfKLB0KzBSGLMgEhLvIK5LmR/Zp+kPYGSEPM7WxT/nHVGlSCgP
         J59ujaUCKkyfuW38pgeto8HWoeDjBlLntAYANpOWuoJEssE2xECr1vzc7UKE+z6Mfnga
         zWS6M5piXX91Lo8KKe2HZmZ7Qu6qF0hzmghRT9ypKZwk6BtUVJzi12CQ6hQ1ObPQjsa3
         0Iv1jqkKzgJ5uUVzGKowwRCdEn+RZSLQ9bIcS0pzrYoakFZnc0/KHw6RsHQBiHMGJa6h
         bkzQ==
X-Gm-Message-State: AOAM532BT34BjjHqlUL95j10MsVM6ty5S1orndF4vVhwt5RG0wY7L68q
        pXe1CJkMFUtxKWkXkvUQRsyd1KoYpOk3mA==
X-Google-Smtp-Source: ABdhPJy4LZ4qRYQ/EzgKEbtLx93esZ0DF/s/yXu22TbdR8k4/hOrATFKivqVvbvYOan9DYnJRExvCA==
X-Received: by 2002:ac8:647:: with SMTP id e7mr8986868qth.156.1621566378701;
        Thu, 20 May 2021 20:06:18 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e12sm3740660qtj.81.2021.05.20.20.06.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 20 May 2021 20:06:18 -0700 (PDT)
Date:   Thu, 20 May 2021 20:06:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org
Subject: config SCHED_CORE
Message-ID: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

make oldconfig gave me no help at all on how to decide whether to choose
SCHED_CORE Y or n, beyond it recommending Y.  Maybe you'll delete that
option later, or maybe removing the prompt string would silence it.

I decided that I probably need kernel/sched/core.o, so chose Y :)

Hugh
