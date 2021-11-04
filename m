Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5A4456A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhKDP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKDP52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:57:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EFC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:54:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r5so7970621pls.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:mime-version:message-id
         :content-transfer-encoding;
        bh=2mq5ANordmcrEkX0PoTEuQw2qzkrF/htgz2kP66qiS0=;
        b=RU4JohCg4W11vjiEq4qR3Jb4+dQbG5X+HdrecLh0R1CNnnTkezNEBvsSWCFur95WBx
         1YYR+29GCrgC8TBzvttlbCwmqJ8qrlohG700ZddwWKVq+zB1u6YUixoUAU9nQ3crg7ad
         smqLLiSloMAwrGBNOfQ/ABSbBLTZqyvP6sDOme8Ja4RmVSN4v7afaHnzP6J7rU7RbdQl
         AwL3xZlnuh20UMi+0UYEYzvKAygty708LbTa1LZSOKTHuwBuJXzjZ8xaCChPeFkBSue8
         lbs78+oaqDcnnetz3cUTaPhAqZIlqJOHpHbeWwdk7LG+YIVocK+f1X9GX67khS9GJe4b
         44hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:mime-version:message-id
         :content-transfer-encoding;
        bh=2mq5ANordmcrEkX0PoTEuQw2qzkrF/htgz2kP66qiS0=;
        b=GU7RVLTspbZWWV/aesEfm7PO65Oj/HR+GwESWFYUSY7FFQJFMv63lSEC+tqcDoB07R
         wSJOnEzEH5vYXp+zqOVWrBhetwnbhgUT+SAttWj6N7Pm41UJj7phxQhFEEt0hc/gMvBF
         u468KnQ5A1ozUXqqej/apYxGZZulE4Eq7ZTSu2JupwWrhSdvMuQRPPOuxD/A5Y6LmKdk
         C6gPYbgxcpcZCNH2zMfJyXeNsu/NHm7r9qYAiXr7ldEuOsY2a1p2yJBw9uMW7q3Hoes6
         NFah9pYLIwsvxYMYGBmARU/Opj0S4iz3lDj2shYNsQ5+B/GxuGKktXFcO1x6FRnRAYvm
         Vl8Q==
X-Gm-Message-State: AOAM532/DhsPp0nY3sR5FLhb7RvLOvnP+XHNEnmlzP5qlzDTAYjRutvE
        czgGnthpwEIp3hTFxzG8JPxHL7KojYo=
X-Google-Smtp-Source: ABdhPJwzFDHHQAe6yHdh3UOvFCxsuJieeW7iaNzbH7/KXrFw5K4v+HOPz5CiXgRUVyXjnKpAZ7S8xg==
X-Received: by 2002:a17:90b:1e44:: with SMTP id pi4mr2852548pjb.245.1636041289778;
        Thu, 04 Nov 2021 08:54:49 -0700 (PDT)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id c21sm5377284pfv.119.2021.11.04.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:54:49 -0700 (PDT)
Date:   Fri, 05 Nov 2021 01:54:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Removal of printk safe buffers delays NMI context printk
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1636039236.y415994wfa.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

It seems printk from NMI context is now delayed indefinitely and
there is no printk_safe_flush equivalent (or I can't see one) to
allow a NMI buffer to be flushed by a different CPU.

This causes hard lockup watchdog messages to not get shown on the
console. I can call printk from a different CPU and that seems to
flush the stuck CPU's NMI buffer immediately.

What's the best way to expose this? Can we have something like tihs?

void printk_flush(void)
{
	preempt_disable();
	if (console_trylock_spinning())
		console_unlock();
	preempt_enable();
        wake_up_klogd();
}

Thanks,
Nick

