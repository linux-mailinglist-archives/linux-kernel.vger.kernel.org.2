Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7041E018
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352585AbhI3RZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbhI3RZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:25:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191CC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:23:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h15so9720157wrc.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=wlLcvdzFoeyeX6JTHYlU53G5ryTrrQ22juicajJlTfk=;
        b=TEn8dbi0SAv6gDVFam+mUmfxq1WU402ZQ14BoQT4A5Dgn+ATYRY+fM3GzfQfS/tdn2
         ivRAgLb6mvYA5coDe5NpTJgQgqaVgnmEbG4/prSAZZ2oLQKBsor3MO85aHiyPzIxjXXk
         druW1LJ5GpxNgwr4HPA/+nhXSNlybV0JIdf2+8cJVMbU5f/Y2U8WlFplEOMVoC06DDqZ
         pyCXpzyGFvtwCU66Gm9uLJgVRwVRehoZeYPxIo8gnnvI29THGHVjSr+0M9n5okT0yqBg
         Z0fa7XWLew2y5Pl+bhO3CeiqZHmpHqq6Wc2iXPed1KQWWmx5/7X1EkGs1ZCPOswtqGb3
         dxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=wlLcvdzFoeyeX6JTHYlU53G5ryTrrQ22juicajJlTfk=;
        b=RmrEtAGMiJE8NesBaT45VSyvvp6kv+R+C2WQyaIxSP8WQjjyKjCggdtHvEDIYLiAh4
         dCmur+7jwkxSqoWaJI9ePgaCyTI2LFfGDi7wZVQHxXmxyYb6TkLmxyZguqXe3Ffye7Xl
         hxzsQGUy2P3GbXvpDYJzhOaMgKZ55U6BAWZNzAZYVWpw+2GzVhsWxWWXDGN7cMXDFouh
         pPyjd3NqMtVxA1kfE5QcxmfhruRCiMMWnpmjcwLNwuzT0BTRUcyEaTN6L17mtebhVYhV
         DldCDI22ItdD3oUwqLyGwBOvsaYKeyg6STfu48VeGrZ/yedb3+fX6cz92X8nNlx5NNxK
         VzuQ==
X-Gm-Message-State: AOAM530QLwjFrFbEazTQd6dsuXrrnhFY/kKlXYtHTaRJ5hGgOlSqVsqK
        edHM1y5gSQb3YxWF3SJwVw==
X-Google-Smtp-Source: ABdhPJwRiMQ/+l19nEWH5Z3Vw9KM4JxoWR0J7T3NvRhtGuRRUplyFhYP1NQc8Sw3FAh/qiHfV/z6tQ==
X-Received: by 2002:adf:dd49:: with SMTP id u9mr7759785wrm.341.1633022619869;
        Thu, 30 Sep 2021 10:23:39 -0700 (PDT)
Received: from [192.168.208.138] ([105.112.33.50])
        by smtp.gmail.com with ESMTPSA id g21sm3419280wmk.10.2021.09.30.10.23.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 30 Sep 2021 10:23:38 -0700 (PDT)
Message-ID: <6155f29a.1c69fb81.659a3.0dde@mx.google.com>
Sender: "Gen.Bella Lagan" <mrssabahibrahim005@gmail.com>
From:   Mrs Sabah Ibrahim <absa50602@gmail.com>
X-Google-Original-From: "Mrs Sabah Ibrahim" <sa2020bah1@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Dear Beloved,
To:     Recipients <sa2020bah1@gmail.com>
Date:   Wed, 29 Sep 2021 17:23:29 -0700
Reply-To: mrssabah51b@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Beloved,

How are you doing, hope all is well? Please I am verifying if your
email is still working, I have sent you several messages, but could
not get any reply from you, would you get back to me? I have an
important message for you.

Please write me through my private email for more clarification:
mrs2018sabahibrahim@gmail.com

Warm Regards,
Sabah.
