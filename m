Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503AA398933
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFBMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFBMSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:18:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27132C061574;
        Wed,  2 Jun 2021 05:16:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l7so1621412qtk.5;
        Wed, 02 Jun 2021 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2O+tLYxesFn9U9bsFgi2no8QVjDlOUPa6ENZe5MNQmw=;
        b=EeDF0BbEfidTuVl9WySidPBvEzrWzs2Q+cL/+DRnZ17L36CgBJG5rHAmiVNYYADsEf
         Om6jDA3bUEhDm2zG0mypmGiVmlV0L76EORgomvcZJIAZeOG02Cv7o2D8YHjpAm/PtRl5
         88adfvVMp7vGoLLLnU09CYf4YBHliIfd2oXarH2187QViNNxUqPJG+LfPqKCZR7ugQxd
         DrfWi5k8vZDLO8AK7PJqCu4pB/PGvRJYyNq0qcwSiq3UyPahFCCAnAd5nJRlw0l2WJ91
         eYYGJ81+BpiTJVtB6HGUwHHEPypPHFZ4jBvS953Pm2n3EOioNyXsWL7oOn3R55M9FYKO
         Ms3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2O+tLYxesFn9U9bsFgi2no8QVjDlOUPa6ENZe5MNQmw=;
        b=Uo2VdGYKMjeGzeXT8scWYqFRhDbuMbmOAj9qJzpFJy7lWFv44+iMDyxDunU4en5h6f
         0TFQTPL8NowgV7kQ5/MB3hQXkQXbQ6gQz0pW/QwvuwXqnR248t/WTO7I7hT9QSxKAbCA
         gX3aHNK1jgrgQerlHcctKCVbJ8kYMDE98Kv7+/EGVWQTIKjDF13T/pU1WAX+LUpoPCGN
         sZ5178/ZUump3BLBZh+qtYRtUCfeqN8sbw2ZNJgxZNKaosuWhoXvg+AUnbuWienJRTnJ
         o+dwC3TUFz5aeQA5HfAT+/1NjYV3q5Op5wZ35jg/JP2SLY///4I51WcBgGJJG3Jmx0oR
         Ixcw==
X-Gm-Message-State: AOAM532xWtWGyavVKHWI86ntWnlHxhQ//Z/VgbhS9ORXxmU/JmdKCJqI
        QEeyFb780QLdW44JD6Pekghri9QrOnc=
X-Google-Smtp-Source: ABdhPJwYLQ/xk/Wo0OcRNo2Y0CbzFrLgMq3CvWfe2xevEe5M9yqxEnQuuI8yVMfH/NsFyL1Yt6JSKA==
X-Received: by 2002:ac8:7f42:: with SMTP id g2mr24436856qtk.73.1622636215380;
        Wed, 02 Jun 2021 05:16:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s18sm2337300qtk.85.2021.06.02.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:16:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 05:16:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Nilsson <daniel.nilsson@flex.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] hwmon: (pmbus/pim4328) Add PMBus driver for
 PIM4006, PIM4328 and PIM4820
Message-ID: <20210602121653.GD2901466@roeck-us.net>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
 <20210601164320.2907-5-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601164320.2907-5-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:43:19PM +0200, Erik Rosen wrote:
> Add hardware monitoring support for Flex power interface modules PIM4006,
> PIM4328 and PIM4820.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
