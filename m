Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77F3406FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhCRNeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhCRNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:34:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27271C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:34:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id x16so2272844iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=lCesJamBNqroHsQblgO5UWKPy+JUA8j7IhgXX+n6vnU=;
        b=HCa0FdikN715kE4ottcPEAjnrP4mUZgh+gTbYTbZmJ7f2ySXG+BXcZkRyB8weVg11d
         6tCrVUXZPDPYNUBkDp/zga0sb0eGovD2K5+GY0k0GT96A74fVpGJRfWKaIuk19J13HG+
         5O4WzngvFwHRdKrXWfM4pOMLvF7CSelhvRWiO1Uy7BEKGEfTwexH8n4HCQWDN4nDFv4o
         FdhdW9yrVQ4F600F0wMhONNAvLs68b+gYB3Y6NRT6wtEWAJCwR4g4fQd8NAeD5jBksRr
         hCxiosIypnsd5PIjq7d7tMT4coWJaFz5wX8XImg8sqrK2fs+L7y4wcIyrZIVNX1ULqbg
         ST2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=lCesJamBNqroHsQblgO5UWKPy+JUA8j7IhgXX+n6vnU=;
        b=kIibZXduZaUXNXDoqNsAARgecPVbcqJb6U8F085Z+mOAm63rZY1cyaypR6Z1UPAGFP
         Y2iigVxpCUeq6zx6XxQPPMxPJnWlomNinL8nbyEIT8+wbAvsIg8vFLnX9Ur0I6M7bqm4
         J+oNSJ+MVOWtBZ3etiI9gu0KlfKyQrms/20J5uxcZxRnHEl996uzj3hVrc124ewip37u
         ARPj32WTLU6eXcqfpxYzmns4Tak0Fg5qJdBhtc+N6sO9l273lj5St56BkXfHhpJe+L4w
         4jVc0reVDtjfQIpldVGhfM6G6Jyf0eKcDeP89k73nf5/9R62cdNzkqFwgOVocq91N7sD
         OLKg==
X-Gm-Message-State: AOAM533FGly6hprL6w+wkGWI1yvgGcP7CHriAIv1ZZN6MAMh/WqCCg6f
        b0eEVangGLDxHPmysqItp4JMMGv5HsNoD/1DHzk=
X-Google-Smtp-Source: ABdhPJwq1o7IePBfvgmV30LJFNAaJGxlem5ITjL5tdcHJRAuynC7zdIvJe/QR1BW8bUnDaJhuaDgj9v1ublx3aq8rMI=
X-Received: by 2002:a02:c6ae:: with SMTP id o14mr7004334jan.33.1616074459699;
 Thu, 18 Mar 2021 06:34:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:b37:0:0:0:0 with HTTP; Thu, 18 Mar 2021 06:34:19
 -0700 (PDT)
Reply-To: sgtmanthey1@gmail.com
From:   kayla manthey <essira17@gmail.com>
Date:   Thu, 18 Mar 2021 13:34:19 +0000
Message-ID: <CAP3UenMN4gUjjx7H-DZJmY5eUOBpuHTxaL6eYVpig4k7wd10Fw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ik wil alsjeblieft weten of je mijn vorige berichten hebt ontvangen.
