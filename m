Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60B357017
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353479AbhDGPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353478AbhDGPXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:23:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89F1361262;
        Wed,  7 Apr 2021 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617809007;
        bh=DCimDHyuXYWeoY+cfqvEmElqTefGTcf3CiVJtJMKOG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvWVbzcHK8920SeCIVOfJEfk8oXK7CiwaxhBaqkw7YJSOb7i/CJIX16cqYvnuRN2w
         ubgDKFPoucWt0zurAaN+5PEFPJWh7sHzbap4SheYD7U3GEXDK18TQ5GkXayiI4VBr+
         570QZZe7xU5qhq2ED+3MjH3k7nhoZZfSquATrJ+g=
Date:   Wed, 7 Apr 2021 17:23:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] USB: serial: TIOCSSERIAL fixes and generic support
Message-ID: <YG3Oba/Xbz1fDW02@kroah.com>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 12:39:01PM +0200, Johan Hovold wrote:
> TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> serial devices is only useful for setting the close_delay and
> closing_wait parameters.
> 
> This series fixes up the various USB serial driver implementations,
> before adding generic support to core for the benefit of all USB serial
> drivers.

Nice fixes!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
