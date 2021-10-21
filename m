Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7302F43680C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJUQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJUQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:39:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF7C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:37:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v20so799981plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XqcJO78xKk2lm0l/Cw0u81IB737YGS5+gZGCiSAkuT8=;
        b=PprdEoHgNItXqDPC7CyuRX8P3aMl241NNV2SAbCOp6MQNVRNVZOfZddf//vsbhPKAW
         mLVENTM79LdZza0c/9QH5Sh8g2cJ0Nb7IC+YAKH5ay2eSrkkKKkx85RQLSFymxbrlUwN
         azxL6Blr3X+JYO/xrfekI3YOJd9jxbW8KER08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XqcJO78xKk2lm0l/Cw0u81IB737YGS5+gZGCiSAkuT8=;
        b=zs67smaPxBRV8CwHeaHDxzK7i/VIwx3nAlj69v0bGpsWL7zepmw9ZUM98esqWjEuBA
         YowfkAbXSxn5xidGNHeKInzIEYT0fWhexrdcORu7A5Hp9JVv297H/TOrEg422B9F3ljz
         5VarK11gXYVGXHQ72mQyhPBsnwQJ6hDj+ovbXEZ52vQzyiLgEmps1ZlTPoxGYPmX/Fpr
         pmyLnt/KJMk6GOh2TLn+esW3mlxhQ5ZSpLV90wuPe02/wI8IhI67uEqx8f+nyJO5TtfU
         6p9WUNK2UXsunjQtbWxOqTDKZ76QbZZ+h9uTrY+5On+GHt669CxjP4iAapSXkQ72H542
         k3gA==
X-Gm-Message-State: AOAM533PFt4Z+PQrIM5OyHcK/2iMysqJCKhDiTUXH2tnTQaf/QdZKjNf
        582OJDSRhMovln/SfKQ7CRjQcg==
X-Google-Smtp-Source: ABdhPJz57dlP9V/G0zQe0IN+kMqXKlAO+Xz6fIoJteFvmAurPwKKejZzQHcvslWADxs0Qkgn5H9iuw==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr7846613pjb.1.1634834263234;
        Thu, 21 Oct 2021 09:37:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm6809230pfe.210.2021.10.21.09.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:37:42 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:37:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 20/20] exit/r8188eu: Replace the macro thread_exit with a
 simple return 0
Message-ID: <202110210937.EA55CEF@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-20-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-20-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:06PM -0500, Eric W. Biederman wrote:
> The macro thread_exit is called is at the end of functions started
> with kthread_run.  The code in kthread_run has arranged things so a
> kernel thread can just return and do_exit will be called.
> 
> So just have rtw_cmd_thread and mp_xmit_packet_thread return instead
> of calling complete_and_exit.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
