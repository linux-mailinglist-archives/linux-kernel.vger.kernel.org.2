Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBABB3495D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCYPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:42:25 -0400
Received: from mx.cjr.nz ([51.158.111.142]:2756 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231565AbhCYPmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:42:06 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 11:42:06 EDT
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id E48237FD53;
        Thu, 25 Mar 2021 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1616686380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqJlqjXqEOA/qrS5l6MiCSUm2Cp6jbH9IweDnJWlXcE=;
        b=aLxrB/YSQGLjh9Vfz/LHIwd4SvH+ek1d7mB7nDoVvPIHOQ5BHd8Fl/f3zC+sDcC4ANMpet
        0Unfpb2F2Qf4PN2Os0xMMiZbJv4sNWniTGn4wSTUajdjgV3R6cF5vTyybmp0bc/7tuv97z
        p8F5BKI9IPkb6vF9oH8P0czICd4ZuT5a0vgdxalavNRU3vtri7zcsN7BBn4n5ToS7yViDo
        zjmfXy3t10jIZcRx7T078y++dsnvjn3aX4mDWzGk9G4BJYbEWPUdD0OdQvUb/ONmD0gW/f
        HoeZ+NaCF7nEfTzEjS6HHFS4Pij1Vd7uMPVYdS/5escH8fFqMGkt2AHzBXr1yQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Steve French <sfrench@samba.org>
Cc:     kernel@axis.com, tom@talpey.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cifs: Silently ignore unknown oplock break handle
In-Reply-To: <20210319135711.11802-1-vincent.whitchurch@axis.com>
References: <20210319135711.11802-1-vincent.whitchurch@axis.com>
Date:   Thu, 25 Mar 2021 12:32:55 -0300
Message-ID: <871rc3fdug.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Whitchurch <vincent.whitchurch@axis.com> writes:

> Make SMB2 not print out an error when an oplock break is received for an
> unknown handle, similar to SMB1.  The debug message which is printed for
> these unknown handles may also be misleading, so fix that too.
>
> The SMB2 lease break path is not affected by this patch.
>
> Without this, a program which writes to a file from one thread, and
> opens, reads, and writes the same file from another thread triggers the
> below errors several times a minute when run against a Samba server
> configured with "smb2 leases = no".
>
>  CIFS: VFS: \\192.168.0.1 No task to wake, unknown frame received! NumMids 2
>  00000000: 424d53fe 00000040 00000000 00000012  .SMB@...........
>  00000010: 00000001 00000000 ffffffff ffffffff  ................
>  00000020: 00000000 00000000 00000000 00000000  ................
>  00000030: 00000000 00000000 00000000 00000000  ................
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>
> Notes:
>     v3:
>     - Change debug print to Tom Talpey's suggestion
>     
>     v2:
>     - Drop change to lease break
>     - Rewrite commit message
>
>  fs/cifs/smb2misc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
