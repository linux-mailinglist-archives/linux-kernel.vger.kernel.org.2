Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4D3C63A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhGLT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:27:05 -0400
Received: from verein.lst.de ([213.95.11.211]:56054 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233614AbhGLT1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:27:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B69E67373; Mon, 12 Jul 2021 21:24:13 +0200 (CEST)
Date:   Mon, 12 Jul 2021 21:24:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: Linux 5.14-rc1
Message-ID: <20210712192413.GA25425@lst.de>
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com> <20210712015619.GA3547193@roeck-us.net> <20210712041423.GA97217@roeck-us.net> <20210712052046.GB8042@lst.de> <0cf6d000-f886-4e99-2e80-78da4ae9367d@roeck-us.net> <CAHk-=wjkQb8DzNg-qAWKWFAS-3Uy-4BUYR0ympb_W-Om=TabNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjkQb8DzNg-qAWKWFAS-3Uy-4BUYR0ympb_W-Om=TabNg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:03:36PM -0700, Linus Torvalds wrote:
> Christoph, can I get that as a proper patch with a commit message?

https://lore.kernel.org/linux-scsi/20210712155001.125632-1-hch@lst.de/T/#u
