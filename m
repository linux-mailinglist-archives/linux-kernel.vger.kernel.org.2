Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E0A435039
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJTQgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhJTQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:36:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB51C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:34:20 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i189so25452552ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBFsFhPpdaw12nk3cu5dcMUG+Fs6Dz9V44jZGeZjmDo=;
        b=OqBB29lMojrufyh9kBCGnAFwOS8hjLJLfsf8n2Ba8h1f/5uZCOE05hS93+aJcabXGy
         BVhAj4obJMShIGQwkkess0Xzu/4lMON7/uG5EC8n2hgiJilyphS92iJtbKB6GxqMMVj0
         01b1sw68aEyHBh6l3BmLzPmgnWatWkddZtNqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBFsFhPpdaw12nk3cu5dcMUG+Fs6Dz9V44jZGeZjmDo=;
        b=C23tsqjD24Tgbq6nlQKK3uhHaLxPuwxd6Ge98NFeX9o7QofmNPWNufh0i1QCojQXrx
         AFdv8PYJALirXPiA+B2X+WIlMXLSNlWggYYV1o9upMxi70ajXFDSyneIGFT5RPmXcRMD
         62ww3ELTSTxwpBijaxGHWwk5q9HPFT+n9Z5CgmlUeWfH2r4aJr+D4siGtZv7/tcqi7zX
         MTdc/ZaXFEsRN7E/9xEzBDv0AgYaTof7eeuCAVN75GBlK6Rmh/rUFjFYQdZra18MfkEU
         Snvn5HEWzi9L1wR+ES+npsgWJumfxdZhP2U5zOqhOAx2hLay69p7yJy8tygCAuWkdj8t
         v+Gw==
X-Gm-Message-State: AOAM531ZI0rkT//Db1udSMXfvVGpzj/rr04cSRYFueWEeWjcnxNpZX0M
        lWTGwzk9NeetSHIxo0kXQyMr/yNZLHR+AA==
X-Google-Smtp-Source: ABdhPJyKtILTXAT9ygIy/vzt9aKqlp949wGCIExiKDHGKGyBz1wFz0eZYaOdqjDC/+gzjVc178Y3Aw==
X-Received: by 2002:a05:6638:32a6:: with SMTP id f38mr241125jav.63.1634747660037;
        Wed, 20 Oct 2021 09:34:20 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id m7sm1346936iov.30.2021.10.20.09.34.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Oct 2021 09:34:19 -0700 (PDT)
Date:   Wed, 20 Oct 2021 16:34:18 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: Retrieving the network namespace of a socket
Message-ID: <20211020163417.GA21040@ircssh-2.c.rugged-nimbus-611.internal>
References: <20211020095707.GA16295@ircssh-2.c.rugged-nimbus-611.internal>
 <CAHNKnsRFah6MRxECTLNwu+maN0o9jS9ENzSAiWS4v1247BqYdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNKnsRFah6MRxECTLNwu+maN0o9jS9ENzSAiWS4v1247BqYdg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 05:03:56PM +0300, Sergey Ryazanov wrote:
> Hello Sargun,
> 
> On Wed, Oct 20, 2021 at 12:57 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > I'm working on a problem where I need to determine which network namespace a
> > given socket is in. I can currently bruteforce this by using INET_DIAG, and
> > enumerating namespaces and working backwards.
> 
> Namespace is not a per-socket, but a per-process attribute. So each
> socket of a process belongs to the same namespace.
> 
> Could you elaborate what kind of problem you are trying to solve?
> Maybe there is a more simple solution. for it.
> 
> -- 
> Sergey

That's not entirely true. See the folowing code:

int main() {
	int fd1, fd2;
	fd1 = socket(AF_INET, SOCK_STREAM, 0);
	assert(fd1 >= 0);
	assert(unshare(CLONE_NEWNET) == 0);
	fd2 = socket(AF_INET, SOCK_STREAM, 0);
	assert(fd2 >= 0);
}

fd1 and fd2 have different sock_net.

The context for this is:
https://linuxplumbersconf.org/event/11/contributions/932/

We need to figure out, for a given socket, if it has reachability to a given IP.
