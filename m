Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD33136F182
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhD2VCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbhD2VCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:02:01 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD4C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:01:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso11534040ott.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=i+9FuwIMl9cHn+tki0o8bt+gHdZhu55DqRpGEfQ0pGzViWg765bEIXZgx8o8jIhHgA
         ZNarjrufek4BhDvtzu4y/vI/gSpknDvODBV6qG+7uExtgN6IeO4rqXgZ/3TuIGrF1huK
         TVHSONx4SfXAPZU3q3Bv0MOORfgn2+vtJZmMYfv0C9NNru9k/bgk70T9CFlF1HEC4qR6
         OAa9DOgkXEJSk7Tkj8l8gfwmNhr55YBGciYbVU8wClIci98wmgMX9hgIy2BQlK3qsRK5
         AiS0RO8tKOOsusO3F7I52SvRHRoTvC7FGSjaLKHFj6aLYPruXddR+0M8+jQaO1Th4QqE
         YxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=AD247X/NFspuWmVErkegOBmLzYwNqG+EaJKdmaqyG7jYdN1rcvnoppwFQIeCcUotUc
         SRjx/FWrZpZ/e2nFn0KH3G/lL1BlzpN8v4qUCjpaNR8PEP0VfbvhCHGgsjw5fSQFtNR4
         81/fkr8dWvzxbbOUjIuwAORkFIfcbRL0f514P12lXGpXc3s2s+r+B5UJOgqpuaONq9Ya
         /cDjtfvFXRuBcC0bv/MSgYkDhvlpJ4daYVnaQ0Qd4Jd6pVZxB8dGCCvMxRmxDkBKnPwl
         yzB4Y4Mh4IimK3X5JnpUfJWdhNwLFXOwKUSf8vHLKk4QP4TJWSYdrmaagSJv7XA0VNeu
         uvlw==
X-Gm-Message-State: AOAM530Fmne6HvC73YgK5uW3bcHHHcGtLNUjBkO54lJF/iTM7YzcK7on
        tK1S16oa1It/cXOYdMhx0TaoYq6aPSPaf37zcOU=
X-Google-Smtp-Source: ABdhPJxPj8dNcnlHmaq5gTrzO5X8kzLQBzT8nkQ+CueIFS6EUZv/KIbMlTkDpdTMD4qwLS8tB93HwS9gv1izKuroo1g=
X-Received: by 2002:a9d:4a85:: with SMTP id i5mr1035034otf.102.1619730073048;
 Thu, 29 Apr 2021 14:01:13 -0700 (PDT)
MIME-Version: 1.0
Sender: sikaadoli@gmail.com
Received: by 2002:a9d:4802:0:0:0:0:0 with HTTP; Thu, 29 Apr 2021 14:01:12
 -0700 (PDT)
From:   kayla manthey <sgtmanthey1@gmail.com>
Date:   Thu, 29 Apr 2021 21:01:12 +0000
X-Google-Sender-Auth: I2vlKNR23_JUALSJm6Hz1oMGDeE
Message-ID: <CA+i=rHKd15jY-Pen0_CB=UiBcXLgPnOfO7jJacgar2KLea6byA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K=C3=A9rem, szeretn=C3=A9m tudni, hogy megkapta-e az el=C5=91z=C5=91 =C3=BC=
zeneteimet.
