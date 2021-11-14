Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17A944F5CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 01:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhKNApq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 19:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKNApo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 19:45:44 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA7C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 16:42:51 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id p37so25117165uae.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 16:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Ft1XPxFVIbWJTs4Ecpf/2qUoKof8ssQDsFByWw2TlxA=;
        b=U0DTrpKxgHQR07w8p1iV9Ryr02cAqy0SeQL+yTJ7btrLaNJzwp15PbETEKeBEanY8D
         YXh23Sywbr+iymo0WWq3pEugSN+llyINEVl79zgR5JNm3mM/P3FuIgC85r6K1/chH88m
         rYtpB3ZECGYf8mdVbbH+kGo22H5LPCd+u0j4/1V/Ep9KCzIby0/PNPFEoCJv4czkrgGR
         dTEC+pgXB8hEAmRSz7nNqPwO6VLWWI69ZWZaueBzxgNUy4vI/V/t/DH92OFfwQWy7sTN
         07BfVpXsLA0VRg7NXuIXDmdYZWsznHmdkWZJ6JygxHCPOy7fC2uZ/4j2cGSFfnuEdyNE
         AIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Ft1XPxFVIbWJTs4Ecpf/2qUoKof8ssQDsFByWw2TlxA=;
        b=S+quYQuOsC4jvLXBBlEHN2YjGbTJ7KPLy+RPkLOZX85PQWvthobIL9fgnQnCmV0h3F
         oE42wTXMFoVKkaRlaLU/M62AKRD9ac2JHC00+v/mPiS3Xc8ZXI7QVM9OJdHMLVKeBIVA
         vFkBLZaawMdosPm7RS6kDXDn+whK1hUfpyfmQROiHnENxu+T9IQkeOrv5lJNPeGXN1zs
         ekOWc42SaqCOSaii0SMuDmQ6FCf0ZSVXf9bCh/hVte0hW3bJ+wInfKUjAh0OjzsIoKQ8
         P0YuZfB1fhp+ZDJLHevhPG4ZlsVhMKAdy3/ZvwI3dmy79026VDCYb3l5KJaYWbw6UbBx
         jhkg==
X-Gm-Message-State: AOAM532pCbdgF6oP82gRB19kzGFpZxn/CK7C1V9omWxWinxX9Opgnmza
        qmlUFeOc008iyfLkDH8aVPs7yiIkjKbj9NOO188=
X-Google-Smtp-Source: ABdhPJx+oi79EkVorojn7V1fk4mZs7yg7YMcTTMtWRwi5qQpQyaHIz5IdGcmX8ylemxvLsX4V8xsrNdpfit3dXimM3g=
X-Received: by 2002:a05:6102:cd3:: with SMTP id g19mr27346738vst.14.1636850570372;
 Sat, 13 Nov 2021 16:42:50 -0800 (PST)
MIME-Version: 1.0
Sender: zerbomaliki@gmail.com
Received: by 2002:a59:8e4e:0:b0:260:cc3:673b with HTTP; Sat, 13 Nov 2021
 16:42:49 -0800 (PST)
From:   "Dr. Hamza Kabore" <hamzakabore97@gmail.com>
Date:   Sat, 13 Nov 2021 16:42:49 -0800
X-Google-Sender-Auth: bqWXQmfI4LaD2HSaVv5DCRJwcuA
Message-ID: <CANEya-joogOaxZc1P1Aic0G3oVm7f4XWCqJnu5oGfxHoWXFbeQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

Greetings and hope this email finds you well?

I am Dr. Hamza Kabore, the  chief Medical consultant at a reputable
clinic here in Ouagadougou, Burkina Faso and I have a Patient who
hails from the Republic of philippines but unfortunately is in Coma
right now due to complications from a Cancer disease and she has the
sum of $10.7 Million United States (Ten Million seven Hundred
Thousand) Dollars she wants me to guide you on, so that her Bank can
transfer it to you for charity purposes.

Please, I will like you to contact me on this email
(hamzakabore97@gmail.com) for further details as this is a very
sensitive issue that needs urgent attention from you and I want to
maintain the promised I made to the woman before she entered Coma,
never to betray her by looking for another person other than you that
she choosed and selected for the offer among the people she got their
email contacts in her quest for an honest person oversea to help her
wholeheartedly in handling this project to fulfill her wish.

Best Regards,

Dr. Hamza Kabore on behalf of
Mrs. Sismer Shirley Acojedo
