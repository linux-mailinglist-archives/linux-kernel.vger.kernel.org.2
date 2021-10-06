Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871D74248BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhJFVU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239603AbhJFVUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:20:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 585C4610A5;
        Wed,  6 Oct 2021 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633555142;
        bh=T70kfDppsNtkEYeSz1kZ0f6cqK4zriDrOQT4jGCJZFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0NNVWEN8StOxrf9UqUHIK+D6Bzi0ZIysadETOS78yvqaArrHEdhfo5dmeSy1gn1a
         iN2PRHDFOaG8UuycjZQCjXkE/2pfuekM++FE0YyOI3g5f5S1IFZyftkFsJywbC1fkO
         iYgPEs4lNcY0nHeRKOO/mUD5SkBsTDK/vyWcWn0wYrfpczQo8I0ExW5QoMkhOpTvWj
         7wwu4ENHjj4RjOMmpkaEjSgHCZPUpdjnebP14hQzkzMwzLJNHZcYazfJq6sXfJkTux
         7TkdbKe6hf9JBMs6rhDYdbLoHa0+xxdlgaSJJxuCyvcbO/RUAgs57KnnQpboEDJXDF
         /7dzZowZLcCQg==
Date:   Wed, 6 Oct 2021 16:23:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211006212308.GA916330@embeddedor>
References: <20211005053922.GA702049@embeddedor>
 <20211005111714.18ebea2b@gandalf.local.home>
 <20211005161812.GA768055@embeddedor>
 <20211005123522.244281e6@gandalf.local.home>
 <20211005165027.GA797862@embeddedor>
 <20211005150807.03da5e54@gandalf.local.home>
 <20211005193557.GA881195@embeddedor>
 <20211005200935.2429ec2c@rorschach.local.home>
 <20211006211426.GA916113@embeddedor>
 <20211006171443.4faecbe9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006171443.4faecbe9@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:14:43PM -0400, Steven Rostedt wrote:
> > OK. Are you going to apply your patch any time soon? So, I can go and
> > enable -Wcast-function-type in my -next tree. :)
> 
> Sure. I only did not add it because of the issue Jann brought up. But if it
> is needed, and I do not want more #ifdef all over the code, I'll add it,
> and perhaps even mark it for stable.

Awesome. :)

Thanks
--
Gustavo
