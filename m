Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0483AFD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVGrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:47:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA7FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 23:45:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d13so28511397ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 23:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SZOgkFHV45vlq/J3+K4vilC0CJEAXKrK5Ld1uca4j/c=;
        b=jxARlqlPVLjPKc5KhEi5TNFNKFBo4dCeS7j5HHydZdTB0+LtKQ4jYzARDhOy4tsjN3
         iPb4SgoOQVEz4cuiRkul75uvHb4N9jrU9zwZcqbxTrSCf/dXcOjfqpbkb0LuzvPZKZAU
         H4H6n4RwPLiCt+xSMRGHr0sYTfUY9y4WMCkLpNKtAIDZ59J87GHcJylAg2igCdZi3GOp
         BRaQxQMg8VDhShhUDvAzi3MqfjwVwAVT63pnwjeTwgvbp73kSxXilagp7f7JyinA3i+Q
         +ncf2acPU/YSg6rTGcCEgj8DJe0bZ16lS1vDC2hdsBJwWCyEaaIFc3tiGmhn+EmzbUyQ
         0/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=SZOgkFHV45vlq/J3+K4vilC0CJEAXKrK5Ld1uca4j/c=;
        b=gQhiSh1qeE9Z7v+TFcid3gWKBrMEPMgOI5dNP9+r+BckNtp7JtfB+idI7bXkl1rlxv
         DARhY+zb7V6kKqPdnoYGDQ5LZpGtPiqlRDdnNJNBxGgWzZpaHlyfKYOuHD8gatt14DDY
         6Kp+Tj2doe2utxrI8HpeVdfErJLKpJZEXTKpbFtux4JbWlE1n9HM3QMdWwah5TC0Z6TM
         0NJi3sGluGLT46u/Z9DWw67BGoEpo8Z42MZecNqZ/1srjLq9U1YfSC1+1/03VN/9aNi0
         dIJMBDcfm7yN+W9Ipa83pIL3PEfrzoa0LhT2SVvyk9vFuSb0+SYbY/4S3O4S8sdXtYJj
         bbIQ==
X-Gm-Message-State: AOAM533KL3Nxe0SRCsGT1EhPXq16Vi0LORrrE/eefR2CYZ3MFuj2/tH1
        nSf18Vvyl696/H/igE0GRrGYzCtjnuWU1Ena4ntF60HjvWnDLZ9z
X-Google-Smtp-Source: ABdhPJxMc4vKACNQ0ZppjB0M3j2Ie45Be3PXy6NL5adlT87Mgd1cLtvnEIsqSVhB8PwdVzzN6Lcft25V5eDTtZ2knwM=
X-Received: by 2002:a2e:a373:: with SMTP id i19mr1894432ljn.394.1624344299452;
 Mon, 21 Jun 2021 23:44:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: tomcrist373@gmail.com
Sender: anitamason903@gmail.com
Received: by 2002:a05:6520:2de4:b029:10a:dc9c:911 with HTTP; Mon, 21 Jun 2021
 23:44:59 -0700 (PDT)
From:   tom crist <tomcrist373@gmail.com>
Date:   Mon, 21 Jun 2021 23:44:59 -0700
X-Google-Sender-Auth: 1pDRm6O0vb5ETV7kxmp_GLnFbUw
Message-ID: <CAFb-CQZyM+Ty3HwF6Zw-1PmTzWrHtL6ojWnfCeaDvMGQcFEfOw@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Tom Crist, de Canadese man die een loterijprijs van $ 40 miljoen heeft
gewonnen, schrijft u om u te informeren dat Google in samenwerking met
Facebook uw e-mailadres heeft ingediend om =E2=82=AC 4.800.000,00 euro van =
mij
te ontvangen, aangezien ik heb besloten een deel van mijn winst weg te
geven aan goede doelen, individuen en organisaties. neem voor meer
informatie contact met mij op via tomcrist373@gmail.com
