Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6D452E74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhKPJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:56:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54858
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233285AbhKPJ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:56:14 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4BA3A3F1A8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637056391;
        bh=4WIA2kLiytpvAuYSWnoOkPVEtpZ6YL0jK44pquUKn9U=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=JTxEm5fIbE/+LyHQkcCx03KZ7Y9ya3fxFLgPpIkmRVUMFRJ4NRoHCFBKVjYyk3QwM
         JK8j2dSFXbppx3mCKESG9uLkxXJLpwzBBFblpWWh0ZFoaDGxofCLqp+DZ4/V1ZP78G
         AZr1iI8Usacqr8mOkfjveC69LuD2SDy8xfOapEfW0zcZSKCxR6A243j0TzHLuKYJB4
         eWF5F8PlgdyxVlGr+qGWiqdOd+A0ZJYorzMrwEU9ouC/OvtVf1xCgqZNLyIGEHbq1n
         +Pe/SOqTxLM+vDTZ4r/ow0OeEK7CSl5k71MOFA92zIfLLfjEPY9j1lMOAjyBRFszur
         xTXnt2Hr07Gbg==
Received: by mail-ed1-f69.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so3431593edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WIA2kLiytpvAuYSWnoOkPVEtpZ6YL0jK44pquUKn9U=;
        b=ZT2ay07fOw8NiK29TnjFNNoXeoVzU09L8d2i6Y0Ps0B1JTjy/VFweIL6v9wXo0SDw6
         Q5B34oItf0SMZkLw6/7E+xKmL3+YLMWeq6hva8KT9RJA6ZlBOCOcXYH/ig4iY1FyqzM3
         ThXQzzEUnxr7zkYFScd4jUcltkIHwe0wxhosAlngtoQtX9bpOEqcjZHrQCecpmFvljEd
         paYY5yY9uNlPqgQWB2utgQCPvMpW1YPgJWFvoaeX1i3xM5sp2xBTgaBnlCHmqDL4OiUL
         7XMTEXGm4xD9juReBL+tPA/j4Yf7HgT+xuWi3Q7ap0zDT9f1xWGMTlZ/GECw2VJx44i2
         b4zQ==
X-Gm-Message-State: AOAM532s0yaPO2KWDfSpD+lGONMFjMd5RYcfayvSpcXGAI+ndnldq1j1
        ihytrVNn8Of9VAm0mTP5Z71AxTSaS/ySt9xeITxfZSnxeWv2e4ZZ/lwWZZd4U7vvRMC+iHWekRB
        D8lXboBdt9q4D1EGU8DTO2Tfngk2e9XLr5uwcUSQUNA==
X-Received: by 2002:a17:907:9056:: with SMTP id az22mr8012873ejc.107.1637056391036;
        Tue, 16 Nov 2021 01:53:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrJT7mP/4j4szg3ywz8prXacs4YZ5ZqVekOM7AHJOO0O7H4hGmwILwNBcGPVNTpuNL27qf+A==
X-Received: by 2002:a17:907:9056:: with SMTP id az22mr8012841ejc.107.1637056390838;
        Tue, 16 Nov 2021 01:53:10 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id hd15sm8280157ejc.69.2021.11.16.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:53:10 -0800 (PST)
Date:   Tue, 16 Nov 2021 10:53:09 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phoenix Huang <phoenix@emc.com.tw>, jingle.wu@emc.com.tw,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] Input: elantech - Fix stack out of bound access
 in elantech_change_report_id()
Message-ID: <YZN/hXipFP7Ipb7G@arighi-desktop>
References: <20211116072223.8746-1-andrea.righi@canonical.com>
 <YZNsoj7Onbxr68OQ@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZNsoj7Onbxr68OQ@ninjato>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 09:32:34AM +0100, Wolfram Sang wrote:
> On Tue, Nov 16, 2021 at 08:22:23AM +0100, Andrea Righi wrote:
> > The array param[] in elantech_change_report_id() must be at least 3
> > bytes, because elantech_read_reg_params() is calling ps2_command() with
> > PSMOUSE_CMD_GETINFO, that is going to access 3 bytes from param[], but
> > it's defined in the stack as an array of 2 bytes, therefore we have a
> > potential stack out-of-bounds access here, also confirmed by KASAN:
> 
> I think a comment in the code why the array size is 3 when only 2 values
> are defined would be helpful. Like a short summary of the above.
> 

Good idea, I like it, I'll send a v2 adding such comment.

Thanks!
-Andrea
