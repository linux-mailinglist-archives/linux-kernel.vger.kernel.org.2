Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50B3D66B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhGZRq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:46:59 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41899 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZRq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:46:58 -0400
Received: by mail-pl1-f172.google.com with SMTP id e14so12748092plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2D7KWiv7vc0sjsa/iS28Qt6i9VASwIkA6EYIfMK6Jp8=;
        b=taDX7tG0GhyRl1Ck3qb6v3wCgZGWKRpSOzCef8j/JzNMROo9pTZBcgXb8w6iSo824I
         JU1m9F6PGXtRJfZDvmQl0uc6uZ6lvD3AJKe+BpIWXENbgLeYzLWSlolutULHTpoWGCcq
         3Vluzns0/p10fQxvTcQNiMZHwBIvlkqhn0kbcpIKzRM/NEdED/pEkfcR6FVkJoQqS1iX
         GEjm05XhxO6w73h4kEs43g38HFMMjnCkQKXFiDX0zv7ffSQ7NTlknLgGASiC9CdriUem
         TpQIT6Y6RFlPGvJBAuQOID+4RzWN5zg/BG8SmidkZwHPyJkJTR/uGy4WCRCLkkVLKA9e
         YJ2g==
X-Gm-Message-State: AOAM531/NR2i914B6ngwNKGrwng6QSlOWT0t+bpE3UNXAH5Uux9nQCMs
        IJbCDk/QF2mmVJyq6D86KoE=
X-Google-Smtp-Source: ABdhPJw7sQkVNo/Yp4bzEHOSZw31rSENhJEbxwWRniSLga25LfW6biXtRawPxD4oXy5FdQrzDteEcw==
X-Received: by 2002:a63:4710:: with SMTP id u16mr12197161pga.232.1627324045472;
        Mon, 26 Jul 2021 11:27:25 -0700 (PDT)
Received: from garbanzo ([191.96.121.228])
        by smtp.gmail.com with ESMTPSA id w2sm631415pjf.2.2021.07.26.11.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:27:24 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:27:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Subject: Re: [PATCH v7 2/2] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <20210726182721.3no7ql73ggttdiyx@garbanzo>
References: <20210724121134.6364-1-mail@anirudhrb.com>
 <20210724121134.6364-3-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724121134.6364-3-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 05:41:34PM +0530, Anirudh Rayabharam wrote:
> This use-after-free happens when a fw_priv object has been freed but
> hasn't been removed from the pending list (pending_fw_head). The next
> time fw_load_sysfs_fallback tries to insert into the list, it ends up
> accessing the pending_list member of the previoiusly freed fw_priv.
> 
> The root cause here is that all code paths that abort the fw load
> don't delete it from the pending list. For example:
> 
> 	_request_firmware()
> 	  -> fw_abort_batch_reqs()
> 	      -> fw_state_aborted()
> 
> To fix this, delete the fw_priv from the list in __fw_set_state() if
> the new state is DONE or ABORTED. This way, all aborts will remove
> the fw_priv from the list. Accordingly, remove calls to list_del_init
> that were being made before calling fw_state_(aborted|done).
> 
> Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
> list if it is already aborted. Instead, just jump out and return early.
> 
> Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com

Curious, how do you get syzbot to test this, I mean your custom tree?

> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>

With the changes Shua requested being made:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
