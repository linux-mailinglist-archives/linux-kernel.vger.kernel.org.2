Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22030C2E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhBBPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:03:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:38166 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234822AbhBBPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:01:00 -0500
IronPort-SDR: X8KJKlLwc+2hqotE7fVRKpPB7f2c4I/Bn87sVqn97Q0XO+nKG1GpeQ3nbz9drNq5izorJWq3qD
 znwQIdbw5ynA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180940722"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180940722"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 07:00:19 -0800
IronPort-SDR: mbSt7PA53ugGhIMr8RjzPt8QGKyFJ0F7jCGOpI00BEsMiCca7FDw79ce31oS5bKtBKlkzm7pQ/
 Tel10bxwbZTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="413617902"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2021 07:00:17 -0800
Date:   Tue, 2 Feb 2021 22:54:45 +0800
From:   Philip Li <philip.li@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch
 help?
Message-ID: <20210202145445.GA14043@intel.com>
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
 <YBguQ/dENrfvtptJ@kroah.com>
 <CAKXUXMwtXTYfs_9Asnmpd09zsucg8tRehMi2Shv8V49H-rs4xA@mail.gmail.com>
 <CABJPP5Dt6KyoaMr-dS9425rozKoCyiPgx9WfoeY2541Aq3MF=w@mail.gmail.com>
 <d5277573215624098109e888c01f4b10fa917439.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5277573215624098109e888c01f4b10fa917439.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:48:04AM -0800, Joe Perches wrote:
> On Mon, 2021-02-01 at 22:41 +0530, Dwaipayan Ray wrote:
> > The idea of a bot seems nice though in general.
> > People do have all the style checking scripts at their disposal, but still
> > we see style issues on the list.
> > 
> > Something similar to the kernel test robot, but for style issues seems nice.
> > Is it something the community would like?
> 
> (Adding lkp)
> 
> Maybe yes, but likely it depends on the particular audience so
> no, not really.
> 
> The kbuild test robot used to run checkpatch on patches and there
> there was negative feedback.  I don't know if the robot is still
> running checkpatch with some subset of message types.
Hi Joe, we had disabled the checkpatch due to low fruit with very limited
useful reports. Is there any recommendation like which kind of types can
be interested?

Thanks

> 
> A thread from 2013:
> 
> https://lore.kernel.org/lkml/20130903003958.GA6855@localhost/
> 
> 
