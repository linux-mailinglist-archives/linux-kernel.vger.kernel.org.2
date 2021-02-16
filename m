Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F831CC17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBPOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhBPOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:35:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7713C061574;
        Tue, 16 Feb 2021 06:34:27 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id j12so6218064pfj.12;
        Tue, 16 Feb 2021 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9AsRqRGn0MWixx73KXgK8PNlpqgSNU3lrracUWioopg=;
        b=YfPfq1/D22BdFQJv0b33A86n9EmS1c2Fzz7teSzpkw4M/nKdIl+3T/LFWDmROy70fD
         lhrg02hYCsmjxv/GYE5aw7Z2p+ph41rjyRf0Gd9hMJN/zQ6qlwXZqsvBgxa7wMbEELKk
         n6Z+EkRuysBZtLwC0UTUcSfowT9faNSU05JSQLE9MYnJb6sujicIDcpd/S/NIaKRGbEs
         F8tpDPl8SueEXLK8MBAd1tl1nCePEsYW7f1cV8xa+mLo3bGO4c0p8Bye2QKwOfKHnM1K
         yC5kKh2RY1spyiDFXJSX2g+M7ZY6S6bssbB0IFlr/yQlZQFeFDCtf3lmJ1MiylIYMHte
         +wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9AsRqRGn0MWixx73KXgK8PNlpqgSNU3lrracUWioopg=;
        b=HSZNQIy/HtSlCeN4MxYuuVd7UK7Q4xMCytvRF53zulskacKbG3uTd1QgQOuHzEoAjH
         RPZavIdzTFLfAEdf0Tel3uOPwNrBl9GKBIM4LlB8ysoqnPUAKF4kWGadkcDn5V1KoJjU
         JWPrAwdvH7tjffbzsGSLyZ+QNrIrtTDR+PyD4LYz83fg+IeG+hFOcD2RF7GX+IkuCuOB
         OUMOlzEwgwzs33PKPJsEQ9onVYhEkCyiJx0hcHqiS8COuPWxgzW2Ucf4rJpGJO1Lh7d8
         J/4aYlIc6M9SsUo+NHg7gzIFYz6TBmF6XwyuwzqZxbB72jDD+RQAfCzIygSLspqabnLD
         WRlA==
X-Gm-Message-State: AOAM530xyWZalWauqGKrkLhZ7IVyKdNR5XsQXtpVHEkSWXZEBQWehp5r
        h5Oyp4RMc7J5+kIHOdAb7Rl+YkEtuPtwrXJLoWvf9lii+ZdHCyuGpZw=
X-Google-Smtp-Source: ABdhPJxuBuoiYoJac6FeR7KQUvNLDiA83ZOlcUQVbCWq+WOJh8251H/R/0rO8eJ4ssfUz3tWXuJsA5mjRbGfymWtcXU=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr20357515pfk.73.1613486066961; Tue, 16
 Feb 2021 06:34:26 -0800 (PST)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Feb 2021 16:34:11 +0200
Message-ID: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
Subject: anonymous enums in kernel doc
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro, can you do some test cases in your workflow against anonymous
enum in ernel doc, please?

They are broken again, please fix the script!

drivers/pinctrl/intel/pinctrl-intel.c:204: warning: wrong kernel-doc
identifier on line:
* enum - Locking variants of the pad configuration

Above is simply a wrong statement.

-- 
With Best Regards,
Andy Shevchenko
