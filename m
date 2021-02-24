Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC53240DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhBXPbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:31:32 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45753 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhBXO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:57:28 -0500
Received: by mail-pf1-f169.google.com with SMTP id j12so1464213pfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bKPiyJ0oXcZow6tjLvovRuhWn+Nhriu5rOTfNOpoLVM=;
        b=JnVTgXZUUn+iLNzLAEg+wDucKaEkPjA7TnvF6Pn4grG87j6rUX2PV7lqepVKTiyJha
         j4FCvVMnGqASZOkx7PzTLVCXajGQdOBUfxzDZvxKXjfaV9vNXshttgPM6pEoPxkCe87d
         K48IIUuNxL1pqdd6wpD9Go4taf9THs/yZ/6frZqUHGxcewvgLFDLLvFtmNKBd67DvlmQ
         BmId58Gl3Zmm/gzZf7hvy0g/T+vYz/Yeusvd+zTPofNLMvSy9mx7VTUHOMEDnQGEUBoN
         FvtihpZmKjMZ3MHeVGs8eA+HGdTtwWKwCKcwH0lMAtdg0k4noA3Gp84GIOkJG/2QgKLD
         1gRw==
X-Gm-Message-State: AOAM532gYXREuc4Tq00hi3A9MFayHMVxwg2K0NZx798bTBJhtw+rUVV+
        6M4Q5ahRt7HwJ0ybaCqPiWg=
X-Google-Smtp-Source: ABdhPJw1d7yDbFCH9iKhCfc2auIZEa5gE3bKfYMd18c+j7qXgPcCJlQAfNeov0CVUDjfEhPRAr/HHw==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr29593852pgh.396.1614178607413;
        Wed, 24 Feb 2021 06:56:47 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.226])
        by smtp.gmail.com with ESMTPSA id e130sm3244742pfh.189.2021.02.24.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:56:46 -0800 (PST)
Date:   Wed, 24 Feb 2021 20:26:41 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fix sparse warnings
Message-ID: <YDZpKcXLkiueequk@karthik-strix-linux.karthek.com>
References: <cover.1613921277.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613921277.git.mail@karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 09:00:48PM +0530, karthik alapati wrote:
> the following patches fixes two  byte-order issues
> and fixes these sparse warnings
> 
> 
> drivers/staging//wimax/i2400m/op-rfkill.c:89:25: warning: incorrect type in assignment (different base types)
> drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    expected restricted __le16 [usertype] length
> drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    got unsigned long
> .
> drivers/staging//wimax/i2400m/fw.c:514:27: warning: restricted __le32 degrades to integer
> 
> 
> karthik alapati (2):
>   staging: wimax/i2400m: fix byte-order issue
>   staging: wimax/i2400m: convert __le32 type to host byte-order
> 
>  drivers/staging/wimax/i2400m/fw.c        | 2 +-
>  drivers/staging/wimax/i2400m/op-rfkill.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.30.1
> 
ping?
