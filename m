Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F163376E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhCKPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234107AbhCKPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615476090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSXAHUgIy3VV7KWzojmN7nVLt65gDscOU1asNHmVCGI=;
        b=AorrySS/LQy58x3zdRFc/UKw7qA8NHVSWS6Ptb2jXEl7Ce4lxCDFTQPnhGoBoD5rWc5iYu
        Pph2Edf1l4rqh8FLs8EG1+g8LEc8PzuWoj/E7+MPguoeFFbiBwTpxb+dn4fKdzc04hZYp2
        bR6tXS5Xfe0kwDyxhQKyuwTTc/yY3YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-h74aRDNlOpGcvJxt9wtY0A-1; Thu, 11 Mar 2021 10:21:26 -0500
X-MC-Unique: h74aRDNlOpGcvJxt9wtY0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE1DC800D55;
        Thu, 11 Mar 2021 15:21:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.196.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id E3A1D60853;
        Thu, 11 Mar 2021 15:21:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 11 Mar 2021 16:21:25 +0100 (CET)
Date:   Thu, 11 Mar 2021 16:21:23 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: Allow other threads to access tracee
Message-ID: <20210311152123.GC15552@redhat.com>
References: <20210310205908.23447-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310205908.23447-1-jnewsome@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Jim Newsome wrote:
>
> @@ -238,7 +238,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	 * be changed by us so it's not changing right after this.
>  	 */
>  	read_lock(&tasklist_lock);
> -	if (child->ptrace && child->parent == current) {
> +	if (child->ptrace && same_thread_group(child->parent, current)) {

Cough... it is not that simple.

Just suppose that 2 threads call ptrace(tracee) at the same time. Say, the 1st
thread does PTRACE_CONT while the 2nd thread tries to change the registers.

Oleg.

