Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89FA3566EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbhDGIfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhDGIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:35:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841B3C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:34:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so867892pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YodPf4w+KP/KQ4oZ3/LgaJa6DCkCE0zYteoLQ1Kua0g=;
        b=QBWshRauOJwgPJ/1WSSMGkpI9QUBneDOZC7IT+yKf8MUVVOZ8bLbSPK2tt4GgwW3qS
         0G8+X3xoYIN1DEHn7oBtMs7flKkeXCvCA/c9oyw7nBa0esmhLHeB5lQx1DEDuW+18AWk
         Mga2n1ByiqVLBZfgzaqIuxHhjr71J7O8FLx0PZLCCwCqebsVOzgJ4d/kJHsikU4G/ygH
         LNhN9q7bufv2Lg+R1AWkzJZvgTcuGYC+rCEIV7zNPsCaWIFINuF8n9mCPR1hTwLWaWSA
         AvzeDmqRD9katToesSc9U04/GWI15ely7ghkMrChmfPB8OLss8jRcFVdulCYjEb3d/yg
         1lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YodPf4w+KP/KQ4oZ3/LgaJa6DCkCE0zYteoLQ1Kua0g=;
        b=q3jHBVawL88mJ9fx1MGZ5eMq0w2uMRb1eSp+W107dxzXfvvlGitZKYoTTtTMi/a0MJ
         q23QfJLIUMo+/ArYCPaQB+CF2tq+2tbPjRRL6cPv1An731smCjWRNyee4j6k5uExgFvV
         1G4eJSlgI+rHHN2VQVvW802Gg/boIaGqOGJ0aD7Q0WJPq+VpN4I19/OpF3WjfY8qkmoo
         3Dr1cjJOt1ddkoLQuK3XKgdtNiiObyWfcReUhb6z7W0z0h5MNwmTqhR3o8fWqgJiE6A0
         TCTmfFVLztVKuG/Q0yyycqurzGtwAVnHf8eyZsyCtTnDcmtidUfZt0zxO9htAlbH5Ogt
         INdg==
X-Gm-Message-State: AOAM53000baobcQV/H6wglEI16/+ohYx6MnjgeJz79GXyHY/OGzga3XN
        znk7JjUpRNr0NUH56cNyMOg=
X-Google-Smtp-Source: ABdhPJx/8yajvSzwzQYCAcss3C7s5sz7i+WWOprBuqLzkR87htJxJpgbrzlHfZbayd/IEqZwpJ8Prw==
X-Received: by 2002:a17:902:e752:b029:e9:5e60:b866 with SMTP id p18-20020a170902e752b02900e95e60b866mr2125037plf.55.1617784493988;
        Wed, 07 Apr 2021 01:34:53 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id r22sm22531858pgu.81.2021.04.07.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:34:53 -0700 (PDT)
Date:   Wed, 7 Apr 2021 01:34:51 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <YG1uq8knhKQsQGU+@localhost.localdomain>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <20210407071117.GA1354@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407071117.GA1354@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:11:18AM +0200, Fabio Aiuto wrote:
> On Tue, Apr 06, 2021 at 11:35:54PM -0700, Pavle Rohalj wrote:
> > Changes in v2:
> >     - Removed type information from variable names
> >     - Broken up the changes into smaller patches
> 
> Hi Pavle,
> 
> I think you missed the subject in cover letter, but maybe
> is not a relevant issue...

(Resending this because I realized I did not reply to everyone)

Hi Fabio,

I did, my bad. This patchset is an attempt to fix checkpatch.pl checks
for camel case usage in sm750fb driver.

-Pavle
