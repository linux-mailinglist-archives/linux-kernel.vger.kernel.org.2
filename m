Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447F136B967
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbhDZSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:53:07 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55109 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237631AbhDZSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:52:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 073CC580B58;
        Mon, 26 Apr 2021 14:51:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 26 Apr 2021 14:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sImtnFIf2IiGLj1moI9Axaabj+1
        /JIUf9WTF63IiVmI=; b=7VLdJfUUGvVQcSqhypULyrzoviMfJLOD8sJ0oV6jKOM
        DreychR1086TvYsxPf2fXhedJhJq3kAJw7r8vXf+WFXLs+pcHkhPhrTsMm5lkbmU
        rZr0NV+13i75V/xFaIILYYtRtQMiv5/vvffYp/32eeYdtgZN/XSv7KhOLzeZvsfn
        lTyG/DmbZzRyIngMbDayAp/55lb8RZRJoB8uMlFgorzf0QgFxcnKDSU4VpuBXSH8
        SDQsGEs1ASoz4xoHUBvdRBQGTXcrz77Qpcsr0IMnkpxJE3T7qgxWaHzGCy1URcOt
        S7wW9aLc0H7IcYXXq25zWXgbuoDgiffDmwaIaSjvdxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sImtnF
        If2IiGLj1moI9Axaabj+1/JIUf9WTF63IiVmI=; b=ZNQLyKaB+hPmesLsB5Gb5X
        FaCa0ONSitPlEOSsHfBfsE9a/4IMCfWVlsy+EIKz90taXHrtOL5Q/Ocdu18c/uWg
        duW1Ej1/K1O0/enz6zMe8baBG+3Bnl960exXDSrfe59KhZw1k85sjjjlkF8m7lz9
        hgVQbBqImTu6t50sjMbFQMhUyCatd6wNDWUBOfuO3vGV+6wPadjyHDV6+JSywEZ2
        bTMXErDJvMRxnVuVj211o2+xx9wndpcSzYggG5VbERxA+PQeJKUCtNoWCUvLIMi9
        YxmvXN7XDpKYUE6bxvcPf+BM9PW7DASJ7+lpwoTgIOZRQZgwFg44G4kd28fEayng
        ==
X-ME-Sender: <xms:vAuHYB4Zxsdj7A-2mRFexalUWN5RaP_0fWTMFs8wv6E8RWWPk_H2-Q>
    <xme:vAuHYO0mB57IUojXRiXPdGdiC2Isjepv8aC49f-Fa3-YUB4dLbTHj4QAM9n0hqgZ5
    CRd5Rl7PRK5tURKLFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddukedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepgeekfeejgeektdejgfefudelkeeuteejgefhhfeugffffeelheegieef
    vdfgtefhnecukfhppedujeefrdefkedruddujedrkeehnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiii
    rg
X-ME-Proxy: <xmx:vAuHYFV2pb_T0tBrJxJDtTqZoKWT7pyknta59rMWrEUsMt7Lt3n_9A>
    <xmx:vAuHYB6tys_XGS2yycR19zEZGqRy35u2fGzfts0FjhMA_pFAjYMsRw>
    <xmx:vAuHYEKzezsxS_peONK4BaophQq9qDBw38Kzx4borrHiYudRdW6mkg>
    <xmx:vAuHYITankRz_KyZaTPVA-yJkwqn_BOd4ZYRe2eIFdQsgVbL6PLENg>
Received: from cisco (unknown [173.38.117.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43CDC1080066;
        Mon, 26 Apr 2021 14:51:39 -0400 (EDT)
Date:   Mon, 26 Apr 2021 12:51:38 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH RESEND 3/5] selftests/seccomp: Add test for wait killable
 notifier
Message-ID: <20210426185138.GA1605795@cisco>
References: <20210426180610.2363-1-sargun@sargun.me>
 <20210426180610.2363-4-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426180610.2363-4-sargun@sargun.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:06:08AM -0700, Sargun Dhillon wrote:
> +TEST(user_notification_signal_wait_killable)
> +{
> +	pid_t pid;
> +	long ret;
> +	int status, listener, sk_pair[2];
> +	struct seccomp_notif req = {
> +		.flags = SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE,
> +	};
> +	struct seccomp_notif_resp resp = {};
> +	char c;
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
> +	ASSERT_EQ(fcntl(sk_pair[0], F_SETFL, O_NONBLOCK), 0);
> +
> +	listener = user_notif_syscall(__NR_gettid,
> +				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
> +	ASSERT_GE(listener, 0);
> +
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		close(sk_pair[0]);
> +		handled = sk_pair[1];
> +		if (signal(SIGUSR1, signal_handler) == SIG_ERR) {

I think here you want a write(handled, "x", 1), right?

Tycho
