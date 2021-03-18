Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FC340AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhCRRFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhCRRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:05:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68756C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:05:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v92so6492339ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M96sX2ER8OUfU5ItsM/N27fVEe7WhfbzfJq6noJZvuE=;
        b=ZptMR85CjXw01KHfTRcq2EVDLfQJLyIzsFLW4Xv6HgfrGrlFg12+R+C8zOG6HlhEB/
         7fc8qRm5U8erwNc6doqipkpQ91OYFve38QvCDgYjVr9GPyul9GsTAhq87hnxO5UTYZ9F
         ICob4RMgHSkZztNvxbg60nbijiHcBh/Zp+y55JtoX4Le6WXBPonFLh0m5dGw6JYZjexN
         iP1QA1ALZx5DfK46KRR8BVflkt9Jhit7aqCtowtNkcSA+im9YzrWe5+XohD50T+vHHD5
         5K+LkcS2Px48VpAuxfTSNGf7l9MNjthVirchi0NerDRWepN9A6M+voEF4VZ+tl215KBX
         NOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M96sX2ER8OUfU5ItsM/N27fVEe7WhfbzfJq6noJZvuE=;
        b=GXmskL7l37P+TPjSSzkzJlPZQz7p+YmgxAIhtI7S+s/na+tcpP4OpGBDzU0j+FRJGK
         NorKzj3J1ntKgYeocZJgcnHfmK1Pxj1X3hsqekVyCJTLANU+Be2UrNAIagyp6k8aazEp
         sx9N3O93err5fLjXWzCDNBreHVXK/B3BkJaxhdEmcfzTMYU3Zb7hBEr2TtMdzJLtmsbR
         ImNKiffFGG2JE+jqzsQ3p5FhFKRdceH0LivvKB75ppaPT+zEwNmIV1slsuUpAjtcLg5d
         3COKdO1ycFSy8B4QUTMZYLewllfXJ6B5zt6Z3K0X/iVlmzyHj4enQtA+Y1/hZt5KFVVA
         2f/w==
X-Gm-Message-State: AOAM532vYFi18nWIpWLnAELHv57PJFdvsEVKFXdxWdmqbQZdhl5i0jxC
        ssVofjO+7OUW5yfQCtCxM4nAHu9QXlxokMAnINo=
X-Google-Smtp-Source: ABdhPJxKgbPt3d9Ql9cYMZo4/Cdz/7X6qGcU8im11P5aoKSknsF2Cq+lDthgDh5Z+ThZ5mNrX8tZu/cYF0CWfwXyNPs=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:840a:6dbd:4c5:5c01])
 (user=ndesaulniers job=sendgmr) by 2002:a25:25d7:: with SMTP id
 l206mr367807ybl.43.1616087103611; Thu, 18 Mar 2021 10:05:03 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:05:01 -0700
In-Reply-To: <CA+G9fYtBw0HAv5OOAycK2rZ_m2Sj73krXPJ0iDzT+O8qtc19SQ@mail.gmail.com>
Message-Id: <20210318170501.2183418-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CA+G9fYtBw0HAv5OOAycK2rZ_m2Sj73krXPJ0iDzT+O8qtc19SQ@mail.gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: Re: s390: kernel/entry.o: in function `sys_call_table_emu':
 (.rodata+0x1bc0): undefined reference to `__s390_'
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     naresh.kamboju@linaro.org
Cc:     acme@kernel.org, agordeev@linux.ibm.com, borntraeger@de.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        lkft-triage@lists.linaro.org, nixiaoming@huawei.com,
        svens@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Replying to https://lore.kernel.org/linux-s390/CA+G9fYtBw0HAv5OOAycK2rZ_m2Sj73krXPJ0iDzT+O8qtc19SQ@mail.gmail.com/)

Yeah, our CI is failing today, too with the same error on linux-next:
https://github.com/ClangBuiltLinux/continuous-integration2/runs/2138006304?check_suite_focus=true
