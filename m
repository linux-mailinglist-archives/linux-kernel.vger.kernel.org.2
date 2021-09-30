Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B741D36F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348089AbhI3Gdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348053AbhI3Gda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:33:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39CFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:31:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l6so3266007plh.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gyrLKv0De6yyODRa16jnm+SfxHUmqz6ZDHmNG+6Xi1g=;
        b=f7IsQBX97Is3sCYEG6NfEKFwqngoDf7mR6pgldjBnukgc10D6B6oFJBPxV1TFk3gvJ
         kuwWL+hxm0jFDp6oSHpEG7Ky5d1LVH0UnKJdM70Xdp6l4JaHz6l8PExmHzX8EWnuqWul
         NKE1ZLrXGLcKbDxR1QC+dYXUXD9hZ72YiqvZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gyrLKv0De6yyODRa16jnm+SfxHUmqz6ZDHmNG+6Xi1g=;
        b=PssaeUNWDEMUkR2+UWCVPcjDtIKac2BzbVFnJar3iK/Vq7JaQ+yedtlhRepZFM1yaz
         groUNIJeDy8srTXUpk0YvVVUuCjIiSMoZDV8SN7yQ0+Ek4yn15bHaMl5RCB5nTn1kvgP
         uhuK2SxvpO/3XdcWNY8fBVTIsMYN2hK3zJZD64z/vFQdzTDNLcn9WOFoF70GjZnZ+8M8
         PA39YnsgiwZ41t8BSn/gJHK8I10ner1OzGwi40lusfGG5rEDA+0KrW9P9LgfNhIMB2Kt
         76kDw4pE4XIUlIdUTcFi+9zfRCcEsPO8E2TL/q++roaDApe0NqwIzGm6vze3c/m4S7Af
         yu7Q==
X-Gm-Message-State: AOAM532RFJ9GCz9F7RwRccRT8+rNjD9mlaT6kvEI9rSyeWoXK4poh9rR
        E5X3mIClDH5AaNzEUqS/yBbcU/tUzHkClw==
X-Google-Smtp-Source: ABdhPJxj+BqBDKVAcE0XKUIsqsj9Cvta0er2MBa+BXV44ddtnpR2lYR2YnDfU8srW3rHSV9wrV4tqw==
X-Received: by 2002:a17:902:db02:b0:13e:683c:7523 with SMTP id m2-20020a170902db0200b0013e683c7523mr2706267plx.43.1632983508394;
        Wed, 29 Sep 2021 23:31:48 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:7dea:cb77:bac7:65dc])
        by smtp.gmail.com with ESMTPSA id c8sm1633541pfj.204.2021.09.29.23.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 23:31:48 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Kai Song <songkai01@inspur.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Kai Song <songkai01@inspur.com>, linux-kernel@vger.kernel.org,
        oohall@gmail.com, paulus@samba.org
Subject: Re: [PATCH] powerpc/eeh:Fix some mistakes in comments
In-Reply-To: <20210927023507.32564-1-songkai01@inspur.com>
References: <20210927023507.32564-1-songkai01@inspur.com>
Date:   Thu, 30 Sep 2021 16:31:45 +1000
Message-ID: <878rze60by.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

Thank you for your contribution to the powerpc kernel!

> Get rid of warning:
> arch/powerpc/kernel/eeh.c:774: warning: expecting prototype for eeh_set_pe_freset(). Prototype was for eeh_set_dev_freset() instead

You haven't said where this warning is from. I thought it might be from
sparse but I couldn't seem to reproduce it - is my version of sparse too
old or are you using a different tool?

>  /**
> - * eeh_set_pe_freset - Check the required reset for the indicated device
> - * @data: EEH device
> + * eeh_set_dev_freset - Check the required reset for the indicated device
> + * @edev: EEH device
>   * @flag: return value
>   *
>   * Each device might have its preferred reset type: fundamental or

This looks like a good and correct change.

I checked through git history with git blame to see when the function
was renamed. There are 2 commits that should have updated the comment:
one renamed the function and one renamed an argument. So, I think this
commit could have:

Fixes: d6c4932fbf24 ("powerpc/eeh: Strengthen types of eeh traversal functions")
Fixes: c270a24c59bd ("powerpc/eeh: Do reset based on PE")

But I don't know if an out of date comment is enough of a 'bug' to
justify a Fixes: tag? (mpe, I'm sure I've asked this before, sorry!)

All up, this is a good correction to the comment.

There are a few other functions in the file that have incorrect
docstrings:

 - eeh_pci_enable - missing parameter

 - eeh_pe_reset and eeh_pe_reset_full - missing parameter

 - eeh_init - missing parameter

 - eeh_pe_inject_err - wrong name for a parameter

Could you fix all of the docstrings in the file at once?

Kind regards,
Daniel

