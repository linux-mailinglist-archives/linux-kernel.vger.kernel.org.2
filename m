Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D445EFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377720AbhKZOjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbhKZOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:36:53 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C269C061792
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:56:34 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k2so18956225lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=uAJacGh/S2+f5JCEbk6JciXT5NiGJwQRo+DeaikSL9Y=;
        b=VK42b90r3hTkN7HU+aSkqWAtzEDiaQ2VNbwVwz38cFZH17vo7w2qZxrxs7JOHFEgLx
         JRd55izY4id5kDAfzf2k5Anpu2LnS8kZWz/gQ+QMMKX7FokBbUEggbyLXa43E0lm4pPE
         n12gti4it0GJ1yiHhLCHDjJzZAai0l34g80NUZY9FTSvVdAs46BnUgaJEyFWQahMYoRD
         GZ9h549FU0ZlTtd3rfZKlvfCObT5dkIllddPqx6qkTlsZfmoB4CjaXFVmuoYC/0mTucS
         49qvkZzor+2T686NRV7hr/OHoLF13jQCbqvmVE2nYv+8PtyshR0iHG7riRMEKB7H020D
         cOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uAJacGh/S2+f5JCEbk6JciXT5NiGJwQRo+DeaikSL9Y=;
        b=za/zOevUYv27zPcwiz6onny2mSPw48I+c5vcWkL8O/4HfH6wKaQKCEkqzaU3e7/oas
         HuntrBvMqiaO+nW8acricXJQJzqbQ6siC1ogk1oOg8U/ZWGHJbmtDRE8oU+EEGRkQKNR
         Kjrwk1QiRDfKjzV2JmcgIaG7k/Yy6VuIafRCcC9ZIfZkt3oaRBWi2lQs2tPtVOplMK/O
         3O8IM4UbTOLeQg6kzgeUUBFDLepZwnvgegyTqy42rsQlpKeHe516Bmuzm92XMI+QlMQo
         wXTLknpx/3HwZfu3ucYNwPH10raiZU36K/xt/huRipd6WgPEDPPBkJsAzKrUD8tjGHqJ
         JkVw==
X-Gm-Message-State: AOAM530Id7iMCf3kE26+E1NkDiQKcg+jMp6gi38DVbb9Jga4jsu9vctQ
        LLRH/lw6yJVF/vWd2MnJ5jgNdtmKyJtaObV0liQ=
X-Google-Smtp-Source: ABdhPJzQQkOdp1Xzw5+OhXdSZsjxEuRjQjpVsI7L9Oz7XX2Nn/GKPL9dVbr2CJBXE2lRZP2XkEmoA0KqQxKAH7375s0=
X-Received: by 2002:a2e:a314:: with SMTP id l20mr32610214lje.86.1637934992494;
 Fri, 26 Nov 2021 05:56:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:304f:0:0:0:0 with HTTP; Fri, 26 Nov 2021 05:56:32
 -0800 (PST)
From:   Liu Gaoshan <graceel047@gmail.com>
Date:   Fri, 26 Nov 2021 05:56:32 -0800
Message-ID: <CAOTqtT60avJ3oRkj-CyVnNLmtVLDaH-G323ZW8GvT_qYbC4NSQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
am Mr Liu Gaoshan, an account officer with industrial & commercial
Bank of china, I am requesting your parnership in Re-profilling funds
