Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA83D667A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhGZR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:27:26 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:45961 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhGZR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:27:21 -0400
Received: by mail-pl1-f173.google.com with SMTP id k1so12529662plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YkBNZMV+7n5H8gA9IlZ5jcPyGMcNQaSbW83IfLj3EX0=;
        b=izwdPlMVHQnFpzUP5dziAN6lmwTWdjSbNSQeI7NlyCBnmamgCh5UzgPS1pfUoKlcrt
         J5RUlyDrlh5I7FhCQXpfA1Kr4jlKXxh7T8LJ+vz3nXZVyUI59fvg0uYafLkO9cOh84Wf
         qz1wKvzlq6g1GJ4MEiWlpM86m0KeB9Fpybnv7yxRUAXkh4j8htNhrNmeIKdalOwT3d5C
         8A9mcDspOaJRG2HaaLgRsJx40+cLrxq8YvZB89TTGsRobTJ0u8KiAWxdkqUrRSkIvHm/
         rDidaXZZjcsHOyedst8W0Gbhnqg3tqmhH1rQsgq/s8f6Goe0tTY0U0N8yAgdfI3mTNrN
         IAVQ==
X-Gm-Message-State: AOAM530H0eTXOJ2yuiQRXtVgwA+X1yqCmgB1YhfzvPZScCgKQ7QBSWq9
        gWBarQqO+1DoDeMIVSAUOCI=
X-Google-Smtp-Source: ABdhPJyquPVeuk0fKONglPfRwZGtA5UjaNmEq/isQ+hwhuQ97ZzUfbz9t4tx9l7tplkg9W15sdpUIQ==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr10103932pfl.57.1627322868624;
        Mon, 26 Jul 2021 11:07:48 -0700 (PDT)
Received: from garbanzo ([191.96.121.228])
        by smtp.gmail.com with ESMTPSA id c17sm674361pfv.68.2021.07.26.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:46 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:07:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v7 1/2] firmware_loader: use -ETIMEDOUT instead of
 -EAGAIN in fw_load_sysfs_fallback
Message-ID: <20210726180744.crfvxbuyz2bjw2o2@garbanzo>
References: <20210724121134.6364-1-mail@anirudhrb.com>
 <20210724121134.6364-2-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724121134.6364-2-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 05:41:33PM +0530, Anirudh Rayabharam wrote:
> The only motivation for using -EAGAIN in commit 0542ad88fbdd81bb
> ("firmware loader: Fix _request_firmware_load() return val for fw load
> abort") was to distinguish the error from -ENOMEM, and so there is no
> real reason in keeping it. -EAGAIN is typically used to tell the
> userspace to try something again and in this case re-using the sysfs
> loading interface cannot be retried when a timeout happens, so the
> return value is also bogus.
> 
> -ETIMEDOUT is received when the wait times out and returning that
> is much more telling of what the reason for the failure was. So, just
> propagate that instead of returning -EAGAIN.
> 
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Beautiful.

As you see, without any of this documented in a commit log, the change
would have been very obscure. Now we cleary document a userspace
changing return value clearly.

Thanks!

  Luis
