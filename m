Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4635528D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbhDFLoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbhDFLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:43:55 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4ADC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:43:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 15so16165206ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fiBLuC1gzj2ls2HyWKhViI8KtJCaxzuMcUl0CY/vuso=;
        b=h5BygVXjkeyDOJLKFavSWMkkqBOorjsWN/yyfRrVjSdu65YdNZ2DlxJIlhB2ZU9isc
         OM9H68o1SrPrVLYhoUgxdj6NqaUSf6tqHiagb7C00A4fd1NpXkGFkO3MSxFyvUfwG1OB
         AIoVKYqamHeNPATkIaLbrWjuJaaJbnjo1fDBbIfYW0n8xSzAbA6SLh+GxHg6H7At4SkM
         sPYNoFGccduLxexSYkfkN4Edze83RL+SAMxFYom24zI6OfBp4l3FyEiqQp0vqOgshusP
         eq3mjhFyv/UEf8+2aC78gpsSVgmaHRyCt4nTaEtCFlaBmCexQe23bgytdpit4HP4tK4Y
         ygeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fiBLuC1gzj2ls2HyWKhViI8KtJCaxzuMcUl0CY/vuso=;
        b=l6A+sEGVL47hTDcD5QaYGM4KJqrqB5KS7JY6IM8lOk4Gg+R0AUX/Z3AMVeZ1iNft5F
         Hi4AOnfVl7QcrywnmEnQbTyW4EQSR6kpTDjqTleauX2hGdmKJQPybttxTf0sh3H9btb8
         GsLvLJB12YwPd7RMyYoGi+y7DkvdhoVOX5wuXO10bILaqUSOTf2w3rZT3+lKRestyCFy
         mZTHbaNNvAmvRmuoUmohHLWUYHkZAyyMLsAIm9c0/StLt2teBF+fvFqQ25WR1bWGOUe+
         E8cvz8G3xqtqDCJEa9XQKoYMjt7gY8ASrdD0ty6Ko3y8L091oos1lcQetpdwY8iQStJb
         vD8g==
X-Gm-Message-State: AOAM532qusks6Q0CCw+ILqpcM0gbH1OazKbssoDANp7X3pF3kEk3k4yx
        n/ODQTkPgoZ575KT0YCGOAw=
X-Google-Smtp-Source: ABdhPJwGOLCglN9gXSieTvFNrKRkT12uUWeNsOtzuSHL9gd3BSzcYqBNHELXxQsMKr/COMgVLXkzSg==
X-Received: by 2002:a2e:9c8e:: with SMTP id x14mr19152814lji.312.1617709424591;
        Tue, 06 Apr 2021 04:43:44 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id y16sm2121267lfy.252.2021.04.06.04.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:43:44 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:43:42 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2 0/2] staging: rtl8712: rewrite comparisons and remove
 blank lines
Message-ID: <cover.1617708653.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces NULL comparisons with boolean negation and
removes extra blank lines after an open brace.

Changes since v1:
	- more detailed descripton of the commit

Zhansaya Bagdauletkyzy (2):
  staging: rtl8712: Rewrite NULL comparisons
  staging: rtl8712: Remove extra blank lines

 drivers/staging/rtl8712/rtl871x_io.h   |  1 -
 drivers/staging/rtl8712/rtl871x_mlme.h |  1 -
 drivers/staging/rtl8712/rtl871x_recv.h | 11 +++++------
 drivers/staging/rtl8712/sta_info.h     |  1 -
 4 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.25.1

