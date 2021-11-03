Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119814445F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhKCQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhKCQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:33:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BC5C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 09:30:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so1804676pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odA894FizgYT2uqpjfguRRE1S63B/axih7mjOQLAm08=;
        b=OIpDm1ALg/qwvFARnuZVOvXmKYt6SVIv/XuBIQNPjQujjPo3LX/hxSqAtcr6anQ+9b
         FgUgp7sSi1NWDQJWcA0USotmuadaVFW3OdifnNjeY1fbDbAMtz0xWjCSMgO26Pqv17kg
         72g01cfgXQLlCFk3PAIjbt0GQHa0S4ZlCZDUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odA894FizgYT2uqpjfguRRE1S63B/axih7mjOQLAm08=;
        b=sHUOrtcuJ3jMLeAC9S6a/wUaCSxdBJga+AtB7FLeb/68yQhTuoMIkn3hV4kWXJzVbQ
         cZCt0rL1/jRCDRvBWxt63p14X0LiVE5fj3m1Oo7WHwLD6fsYz5w1jFkd/+F1AYjS9784
         E0A4bznPbfeTAosSv/LQiyUCfExYtD067Xk2Tr5R1zzFIj9hTBottqvjFBEy0V/reaRH
         ajudbXm1Nb7Yn9fsMnUuiIY9nNdtJPUe+LKLbobUBlmgxE0sfuZ6jpvti5N1xLVLz/mk
         y+/uRD2h/iUjvxYUWRdaJy99MDXHpV/dPTHwhnYZE87NK0pNDiOTImTIt9dSAP7DcjH8
         cmcQ==
X-Gm-Message-State: AOAM533jCjvdvb1Lc1BJD7nJ0vOWhZycwdNfl43vKHdYnrs+e7KO8V0r
        ZhVNMAVvMdd1ccGo0QN4VwhjRQ==
X-Google-Smtp-Source: ABdhPJxqHPFG+x4rwiV8Mgj3grtvz42LF03NLpAtBBMNOAXSQoeECLEJUC/OA5E0KQz31slWgI4bOw==
X-Received: by 2002:a17:90b:390e:: with SMTP id ob14mr9186031pjb.44.1635957044237;
        Wed, 03 Nov 2021 09:30:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p14sm2250717pjb.9.2021.11.03.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 09:30:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] selftests/seccomp: Report event mismatches more clearly
Date:   Wed,  3 Nov 2021 09:30:37 -0700
Message-Id: <20211103163039.2104830-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=496; h=from:subject; bh=bBcjzOR1RktEnR+WvZ1blWW2pvGaJgCZ/HftjhRG4ng=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhgrku01EHfrhMdq4hLtNKWO/m2RdoO65pi/ftqDp6 UFbzSbmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYYK5LgAKCRCJcvTf3G3AJtTZD/ 4o1jD+SyQTsbUKkFJbgto1xyzQMiDwRrCEovTQfixmizO0VQchPSDeZOIcKUhJhRg2h1AJ9fJ0nHEP 4KcS+MHoGO7ZWRYdNDI/k1xGZ9uYwp2Ir/E6DI+FfAYDDGaXWlUnipQ+ITqPCZ6Qw0TC8GYrXebcm8 fxhevz+e1cScBY+Ze/2ESESVSNa6GfWF2Et52tbPCOM53jv0Ni96BqiAM2vDeZPgicP4pYuPD4IVLC gGgpX8M1i8bnmRU9bgBg8QDoyry8soLa2jBy3p6JQmA62YoPNcdpwEPe/iQZ0sAYlP+vHIafzVYKw9 JhbQ0PYy9aPrUdC4FOLDf0nvEVbFn0oVA262dshM2mR/8oVj/GoE1o8zTl0V9G0rR3cCVZmW/nZaSL ckokBw9Wt0gIDLgbNjCbYfLESxEXBYLfIaGQ03bPaL/oAxK7knZGLs6CT5P6NHnUYeW64V8soQp0VW NtkMVfDXoiw7jRmch7Y1M6yUMwwXYNfhwSm31tWt2KqMSTlYZtjaBTENd0hxmH/dr9dAs7ICzB1VhT uHCYZM4++xnkbVCvTIAWTJFoYoMHsaWsKDsfoyU65peKPOMceRRlooh/Tv+dr/pHM+yyZSXuemduxt 7fM+N55zkew0PoEsrtr7vKLCssy3AItHKHD3m5BvZOEUTJf9z9IcG5wppt4A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This expands the seccomp selftests slightly to add additional debug
reporting detail and a new "immediate fatal SIGSYS under tracing" test.
I expect to be taking these via my seccomp tree.

Thanks,

-Kees

Kees Cook (2):
  selftests/seccomp: Stop USER_NOTIF test if kcmp() fails
  selftests/seccomp: Report event mismatches more clearly

 tools/testing/selftests/seccomp/seccomp_bpf.c | 56 +++++++++++++++++--
 1 file changed, 50 insertions(+), 6 deletions(-)

-- 
2.30.2

