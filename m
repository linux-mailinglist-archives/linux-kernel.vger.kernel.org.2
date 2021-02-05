Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54651310197
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhBEA0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhBEA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:26:32 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2DDC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:25:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u25so7390011lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mWUC9raZmLhQ3ceN3MrZhM8r0G2MwByPq7r3xx9bdMU=;
        b=kf+Qw30TK8E0utWaGyD5Qm9RFOxgRmPqqRCAxXevqG6C42hhHQsN9m03fMwd75HGon
         FzkfqxfvzshWQ79kWau9C40BPyIrxhHuMt4eVykJZryXCKdu2+GDUu+XoeUnHBV83az+
         Q4YoiHSiDgiGh2E3vy3xe+z9b8gkP9DsRZXLzFcbumSfpJ+1kmhxEhHQTJMik74Cr9mc
         yJZNXsGQF4Kk+1MaVjwydFNEMW8Uy99ea6V2C99XWgplAOym/knidkxUS+H2UXiASRJ7
         SQlE0pA7QZYU0U59vj8CFiiJ72Y3HxcL9fke77c/JMPoTlWVAXoNyOt7uJKzv21n1YHC
         l0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mWUC9raZmLhQ3ceN3MrZhM8r0G2MwByPq7r3xx9bdMU=;
        b=ISD7sfdmonqeETb2K/0ViT+4RvD9oCp9/YpymThDta2RLhhLSg2Ug4+2KBg8HCAtK0
         gcwltT9R448isbf9Rfs3lDlU24TLp67LOcXU/wYYOKS7Vr0Bsv6Tt0OcoQbNO7uKoLwz
         JYco51oUU411wVBY0uoZounxnztWvV3omtCfGIuY6dbHkJjkYkgkFlY6Uds25XuVCtMj
         9Z2BVJVlcYBIKWaKHWaFRYhWwDSuk+cqsYd+U5pMxsWL+HIANZBJmEm0gyNxDDEMw4oR
         xqETf1Ah6yCvvuLsitcFvSNouQfmFk42TB8a7Zr8rPPBo0ffkUdfs8eNfBm9jhV/5PjN
         lMew==
X-Gm-Message-State: AOAM530ytyR4p/ODTxAwFZ3P24lH+jnJuWwUKEHjKf5W0lZcaLSI9A0e
        IjmderC4sZ+pmj5v+R5Em56oyGdi6oq9fWoJRtg5arnN+SJQeA==
X-Google-Smtp-Source: ABdhPJy1kwPrQbNJfWcNpD08mi+T658q750JtIe1AcQWhXWWeCb9/B3dC44E6keq2mLWDhYL/nRJtaoevFJxM4OKFSg=
X-Received: by 2002:a05:6512:2028:: with SMTP id s8mr1004891lfs.62.1612484750691;
 Thu, 04 Feb 2021 16:25:50 -0800 (PST)
MIME-Version: 1.0
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Fri, 5 Feb 2021 00:25:39 +0000
Message-ID: <CAB3wodc7L-fxnAFRBaSEFWCT8FfRj2eTRxa7ucdWUK2=pA87Gw@mail.gmail.com>
Subject: Greylisting on linux-kernel broken?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have sent a patch-set from my usual email address
(phillip@squashfs.org.uk), but despite over 18 hours it has still not
shown up.  Instead I have received bounce warning emails that they are
delayed.

I have sent emails to autoanswer@vger.kernel.org and
Majordomo@vger.kernel.org, and they have not been delivered either.

Is  there something wrong here?  It is impossible to get an empty
email to autoanswer@vger.kernel.org wrong so it is delayed AFAIK.   I
have used http://vger.kernel.org/mxverify.html to check that the MX
records appear correct.

Thanks for any help.

Phillip Lougher
Squashfs maintainer
