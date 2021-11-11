Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3A44DB42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhKKRv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhKKRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:51:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3AC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:48:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r8so11083207wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CuWEymX5xt6zjmYESOk0bUe+rAc8grM/AjSTsJ8fdkI=;
        b=nhmt4hxnLvhLA6o/IjSCUNvoaXYKwfnkl/uccNCXw7YHpInfzxqFyEN3UwYAde1Hyl
         7LIJdZg0o5tDBnoHe6xCKZ2V0vX3aq1VcrHSeHmSRHffiQuN2A7iiGKgYeaBlUtrTsEU
         V1AapG0l30CJ6qoYTrEntOtxWnR8xy9gNWLrcCfC1apNeZhg9wj5Uc4FsNs4kT+f64lT
         pMm1jdgVNn5i84v1tBc/pJZmGgZZWL1qLcAN/7CCLqlzYUjCY4F8BwKzH2xBxwprf2s4
         uh4XP3qwBGKGTfufZJIKn8bDSyxC5MonaOPOb5Mugcmn4GVaaOpWoW8pj7zRSxuOo6io
         e5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CuWEymX5xt6zjmYESOk0bUe+rAc8grM/AjSTsJ8fdkI=;
        b=QNlmF5l6goknN52OM8hoFCyln7W84fqZtZHxT5WihLWw89P/liQXUMH8COaUC1r9xA
         FVFTJlGrp4KfBnOBaKRG3QXIZUKr5yjMcVZRiDZJo4fH29v11buhvPeGUkCMTUM0zsTH
         4DeIHGJFnZ4+6ltUN5cKeUspQY3+3jRcbTVNSjRa74bnnWevmMbZhJSH5vdIoe4ZFW2k
         s5+sZllX8Sbao9GD8OXNY1G/4N1tDYXDd48nuSaRAAi8NhU02Dk4/szgn96zmDizC3t2
         f0KXRtQkBMihkLEVLuwb+PkSFGgo7cF/cb2i337mQvpbD/8LGWCIlFHN9nqWFA+BMV25
         nARA==
X-Gm-Message-State: AOAM533PJ0yO8VMLs84bWoyqLra8oGFl+6r9wFGHn+0JlYe0vZ4JETRi
        rO0zUykZFXtq+TafrsuOCMnZEgtdqQgReDLwLSM=
X-Google-Smtp-Source: ABdhPJzcv87jawubfxhLoXCJZw51pybJoSJ9yu4FT3IqyFTkd7xwmipdBHvC1ztLeL4vj57MfhyAhc+MgEsL5mGz39U=
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr11196517wrs.266.1636652914877;
 Thu, 11 Nov 2021 09:48:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:18c7:0:0:0:0 with HTTP; Thu, 11 Nov 2021 09:48:34
 -0800 (PST)
Reply-To: alimaanwari48@gmail.com
From:   Alima Anwari <khuntamar5@gmail.com>
Date:   Thu, 11 Nov 2021 18:48:34 +0100
Message-ID: <CAOdLAAJ+ayea0C0L0YZPvTA+yAxj-kPCtyC5hVpJARh0TyanQA@mail.gmail.com>
Subject: =?UTF-8?B?0J/QoNCY0JLQldCi0KHQotCS0KPQrg==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0YHRgtCy0YPQudGC0LUsINC00L7RgNC+0LPQvtC5INC00YDRg9CzLCDR
jyDQkNC70LjQvNCwINCQ0L3QstCw0YDQuCDQuNC3INCQ0YTQs9Cw0L3QuNGB0YLQsNC90LAsINC/
0L7QttCw0LvRg9C50YHRgtCwLCDQvtGC0LLQtdGC0YzRgtC1DQrQstC10YDQvdGD0YLRjNGB0Y8g
0LrQviDQvNC90LUsINGDINC80LXQvdGPINGB0YDQvtGH0L3QsNGPINC/0YDQvtCx0LvQtdC80LAs
INC60L7RgtC+0YDQvtC5INGPINGF0L7Rh9GDINGBINCy0LDQvNC4DQrQv9C+0LTQtdC70LjRgtGM
0YHRjy4g0Y8g0LHRg9C00YMg0LbQtNCw0YLRjA0K0LfQsCDQstCw0Ygg0L7RgtCy0LXRgi4NCtCh
0L/QsNGB0LjQsdC+Lg0K0JDQu9C40LzQsC4NCg==
