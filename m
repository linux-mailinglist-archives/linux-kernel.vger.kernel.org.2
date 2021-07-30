Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3B3DBBBF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhG3PJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:09:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35928 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbhG3PJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:09:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8022A20261;
        Fri, 30 Jul 2021 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627657772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PewmghU2Couc38HMuAXRIJRdxdZpqKISKEL9LkxlGXw=;
        b=m32RFSN03HsyR6LMfDu3cVlNl/piAvHbYqy6dEEKHRSZM9Z/CHN0unfaiRnO7UZ9UFzqSR
        WehhpA5Xo8eeE+TbS2yoms4YN0Clxc83rtKuu9fR7278hrqRq8HN4lyKhzZK7RxSIIkRp4
        MUzGXfhxydGsS7qr+WbWoNkxcjcEi7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627657772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PewmghU2Couc38HMuAXRIJRdxdZpqKISKEL9LkxlGXw=;
        b=w1VCpaNUUNiVdp3wJEdGoU2dSvIPf6chr7uoqFXucgj/ovNDLhhaREff7YYRjIggtl8tVF
        VBqWXpuFtHN74jDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E0C413C32;
        Fri, 30 Jul 2021 15:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SSpcGiwWBGFVHAAAMHmgww
        (envelope-from <dbueso@suse.de>); Fri, 30 Jul 2021 15:09:32 +0000
MIME-Version: 1.0
Date:   Fri, 30 Jul 2021 08:09:32 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     cgel.zte@gmail.com
Cc:     keescook@chromium.org, christian.brauner@ubuntu.com,
        ktkhai@virtuozzo.com, jamorris@linux.microsoft.com,
        varad.gautam@suse.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] ipc: add set_ownership() and permissions() callbacks for
 posix mqueue sysctl
In-Reply-To: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
References: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
User-Agent: Roundcube Webmail
Message-ID: <4b67a8df7823cc14ffb69657c82562b2@suse.de>
X-Sender: dbueso@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-28 20:06, cgel.zte@gmail.com wrote:
> This patch adds a ctl_table_set per ipc namespace, and also the
> set_ownership() and permissions() callbacks for the new ctl_table_root
> for ipc mqueue syscgtls.
                   ^^ sysctls

This makes sense to me, just some nits below.

Acked-by: Davidlohr Bueso <dbueso@suse.de>

> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
...
> +static int set_permissions(struct ctl_table_header *head,
> +				struct ctl_table *table)
> +{
> +	struct ipc_namespace *ipc_ns =
> +		container_of(head->set, struct ipc_namespace, mq_set);
> +	struct user_namespace *user_ns = ipc_ns->user_ns;
> +	int mode;
> +
> +	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
> +	if (ns_capable(user_ns, CAP_SYS_RESOURCE))
> +		mode = (table->mode & S_IRWXU) >> 6;
> +	else
> +	/* Allow all others at most read-only access */
> +		mode = table->mode & S_IROTH;

Please use curly braces for the else.

> +	return (mode << 6) | (mode << 3) | mode;
> +}
> +
> +static void set_ownership(struct ctl_table_header *head,
> +				struct ctl_table *table,
> +				kuid_t *uid, kgid_t *gid)
> +{
> +	struct ipc_namespace *ipc_ns =
> +		container_of(head->set, struct ipc_namespace, mq_set);
> +	struct user_namespace *user_ns = ipc_ns->user_ns;
> +	kuid_t ns_root_uid;
> +	kgid_t ns_root_gid;
> +
> +	ns_root_uid = make_kuid(user_ns, 0);
> +	if (uid_valid(ns_root_uid))
> +		*uid = ns_root_uid;
> +
> +	ns_root_gid = make_kgid(user_ns, 0);
> +	if (gid_valid(ns_root_gid))
> +		*gid = ns_root_gid;
> +}

Could set_permissions() and set_ownership() be factored such that we can 
avoid duplicated code between ipc and net ns? Something like:

void set_permissions(struct ctl_table_header *head, struct ctl_table 
*table)
{
     struct ipc_namespace *ipc_ns = container_of(head->set, struct 
ipc_namespace, mq_set);
     set_permissions_common(ipc_ns->user_ns);
}

Thanks,
Davidlohr
