Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0AD3ECA71
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhHOR0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 13:26:51 -0400
Received: from smtp1.axis.com ([195.60.68.17]:57086 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhHOR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 13:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629048380;
  x=1660584380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rj75vdBZosRGs+WpKUi5mHiJk4BWCJsnQya1hMpflr4=;
  b=Ccr9Zl8QsZZuY2TNkIdgH4p7WJno9cUbCyAorCn09rVDkPkYzn4jeLBH
   FIu5gW9ivAFraeN5ZXlZhSz2lQJlZBQIl0XQIxYPWDa6bBu0luSkXEpjB
   JrdTw+epD7SziJliuk9GqXjqG00reM5W5h7ZCeL55okf4nDNBXqkSuYjL
   SQdfxeN4KW1EsYfHolxWOhWrvyIFoS0wF/2n4ApPDzkUth54CSQBgmlCP
   SMiSfqHEv6tjpRBBT//ssMivz9XyU2WLk4zHpPb4yAJy57Vw+53w0ND+U
   83fh7LobRfuuz6HlEi2A2erLT0h223FfYDIIni1kRFiqzAbgLTGEdqpo6
   Q==;
Date:   Sun, 15 Aug 2021 19:28:58 +0200
From:   Borys Movchan <borysmn@axis.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Borys Movchan <Borys.Movchan@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Message-ID: <20210815172858.GA14375@lnxborysmn.se.axis.com>
References: <20210809174731.27924-1-borysmn@axis.com>
 <20210810175312.ziglxdlqimsmxbak@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210810175312.ziglxdlqimsmxbak@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail07w.axis.com (10.20.40.13) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:53:12PM +0200, Jarkko Sakkinen wrote:
> On Mon, Aug 09, 2021 at 07:47:30PM +0200, Borys Movchan wrote:
> > If something went wrong during the TPM firmware upgrade, like power
> > failure or the firmware image file get corrupted, the TPM might end
> > up in Upgrade or Failure mode upon the next start. The state is
> > persistent between the TPM power cycle/restart.
> > 
> > According to TPM specification:
> >  * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
> >    to all commands except Field Upgrade related ones.
> >  * If the TPM is in Failure mode, it will allow performing TPM
> >    initialization but will not provide any crypto operations.
> >    Will happily respond to Field Upgrade calls.
> > 
> > Change the behavior of the tpm2_auto_startup(), so it detects the active
> > running mode of the TPM by adding the following checks.  If
> > tpm2_do_selftest() call returns TPM2_RC_UPGRADE, the TPM is in Upgrade
> > mode.
> > If the TPM is in Failure mode, it will successfully respond to both
> > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM is
> > in Failure mode.
> > 
> > If detected that the TPM is in the Upgrade or Failure mode, the function
> > sets TPM_CHIP_FLAG_LIMITED_MODE flag.
> 
> Does this apply for TPM 1.2? Are there differences?
> 

Actually I am not sure, I am working with TPM 2 exclusively have no
knowledge regarding other versions.

> > The limited mode flag is used later during driver
> > initialization/deinitialization to disable functionality which makes no
> > sense or will fail in the current TPM state. Following functionality is
> > affected:
> >  * do not register TPM as a hwrng
> >  * do not register sysfs entries which provide information impossible to
> >    obtain in limited mode
> >  * do not register resource managed character device
> 
> Maybe for consistency call it TPM_CHIP_FLAG_UPGRADE_MODE? It makes easier
> to "connect dots" later on (has probably something to do TPM_RC_UPGRADE).
> 
> 

My idea was to group both Failure and Upgrade mode and call them limited
mode. As functionality of the TPM is limited in both of them. I was
afraid that if I call it upgrade mode and map failure mode into it, it
might get confusing. So please confirm that you prefer to name the flag
as TPM_CHIP_FLAG_UPGRADE_MODE.

> > 
> > Signed-off-by: Borys Movchan <borysmn@axis.com>
> > ---
> > 
> > Notes:
> >     v2:
> >      * Commit message updated.
> >     
> >     v3:
> >      * Commit message reworked.
> >     
> >     v4:
> >      * Description of how tpm2_auto_startup() detects the mode added to
> >        commit message.
> >     
> >     v5:
> >      * Introduce global flag: TPM_CHIP_FLAG_LIMITED_MODE.
> >      * Add checks for the flag in places that will not work properly when TPM
> >        functionality is limited.
> >      * Avoid registering sysfs and character device entries that have no useful
> >        function in limited mode.
> >      * Do not register TPM as a hwrng.
> >      * Do not try to obtain any crypto-related properties from TPM as it will fail
> >        in limited mode.
> > 
> >  drivers/char/tpm/tpm-chip.c  | 16 ++++++++++------
> >  drivers/char/tpm/tpm-sysfs.c |  3 +++
> >  drivers/char/tpm/tpm2-cmd.c  | 13 ++++++++++++-
> >  include/linux/tpm.h          |  2 ++
> >  4 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index ddaeceb7e109..8d159db39392 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -444,7 +444,7 @@ static int tpm_add_char_device(struct tpm_chip *chip)
> >  		return rc;
> >  	}
> >  
> > -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !(chip->flags & TPM_CHIP_FLAG_LIMITED_MODE)) {
> 
> You cannot rely on validity of TPM_CHIP_FLAG_TPM2, as tpm_tis driver
> uses a TPM command to probe the TPM version.
> 

Good point, will fix in next patch version.

> >  		rc = cdev_device_add(&chip->cdevs, &chip->devs);
> >  		if (rc) {
> >  			dev_err(&chip->devs,
> > @@ -506,7 +506,8 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
> >  	struct attribute **i;
> >  	int rc;
> >  
> > -	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
> > +	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL) ||
> > +		chip->flags & TPM_CHIP_FLAG_LIMITED_MODE)
> >  		return 0;
> >  
> >  	rc = compat_only_sysfs_link_entry_to_kobj(
> > @@ -536,7 +537,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> >  
> >  static int tpm_add_hwrng(struct tpm_chip *chip)
> >  {
> > -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> > +	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || chip->flags & TPM_CHIP_FLAG_LIMITED_MODE)
> >  		return 0;
> >  
> >  	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> > @@ -550,6 +551,9 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> >  {
> >  	int rc;
> >  
> > +	if (chip->flags & TPM_CHIP_FLAG_LIMITED_MODE)
> > +		return 0;
> > +
> >  	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> >  	     tpm2_get_pcr_allocation(chip) :
> >  	     tpm1_get_pcr_allocation(chip);
> > @@ -612,7 +616,7 @@ int tpm_chip_register(struct tpm_chip *chip)
> >  	return 0;
> >  
> >  out_hwrng:
> > -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> > +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !(chip->flags & TPM_CHIP_FLAG_LIMITED_MODE))
> >  		hwrng_unregister(&chip->hwrng);
> >  out_ppi:
> >  	tpm_bios_log_teardown(chip);
> > @@ -637,10 +641,10 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
> >  void tpm_chip_unregister(struct tpm_chip *chip)
> >  {
> >  	tpm_del_legacy_sysfs(chip);
> > -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> > +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !(chip->flags & TPM_CHIP_FLAG_LIMITED_MODE))
> >  		hwrng_unregister(&chip->hwrng);
> >  	tpm_bios_log_teardown(chip);
> > -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > +	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !(chip->flags & TPM_CHIP_FLAG_LIMITED_MODE))
> >  		cdev_device_del(&chip->cdevs, &chip->devs);
> >  	tpm_del_char_device(chip);
> >  }
> > diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> > index 63f03cfb8e6a..43ea9c66342d 100644
> > --- a/drivers/char/tpm/tpm-sysfs.c
> > +++ b/drivers/char/tpm/tpm-sysfs.c
> > @@ -478,6 +478,9 @@ void tpm_sysfs_add_device(struct tpm_chip *chip)
> >  {
> >  	int i;
> >  
> > +	if (chip->flags & TPM_CHIP_FLAG_LIMITED_MODE)
> > +		return;
> > +
> >  	WARN_ON(chip->groups_cnt != 0);
> >  
> >  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index a25815a6f625..598d62695310 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -729,7 +729,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >  		goto out;
> >  
> >  	rc = tpm2_do_selftest(chip);
> > -	if (rc && rc != TPM2_RC_INITIALIZE)
> > +	if (rc == TPM2_RC_UPGRADE) {
> > +		dev_info(&chip->dev, "TPM is in upgrade mode, functionality limited\n");
> > +		chip->flags |= TPM_CHIP_FLAG_LIMITED_MODE;
> > +		rc = 0;
> > +		goto out;
> > +	} else if (rc && rc != TPM2_RC_INITIALIZE)
> >  		goto out;
> >  
> >  	if (rc == TPM2_RC_INITIALIZE) {
> > @@ -743,6 +748,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >  	}
> >  
> >  	rc = tpm2_get_cc_attrs_tbl(chip);
> > +	if (rc) {
> 
> Why all rc's apply?
> 

Different vendors return different error codes here. Some, like STM
return vendor specific ones.

> > +		dev_info(&chip->dev, "TPM is in failure mode, functionality limited\n");
> 
> Here is again a different name for the same thing (different than
> TPM_CHIP_FLAG_LIMITED_MODE).
> 

This check is triggered only if TPM is in Failure mode. It is different
from Upgrade mode.

> > +		chip->flags |= TPM_CHIP_FLAG_LIMITED_MODE;
> > +		rc = 0;
> > +		goto out;
> > +	}
> >  
> >  out:
> >  	if (rc > 0)
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index aa11fe323c56..231d7c7ec913 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -207,6 +207,7 @@ enum tpm2_return_codes {
> >  	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
> >  	TPM2_RC_FAILURE		= 0x0101,
> >  	TPM2_RC_DISABLED	= 0x0120,
> > +	TPM2_RC_UPGRADE		= 0x012D,
> >  	TPM2_RC_COMMAND_CODE    = 0x0143,
> >  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
> >  	TPM2_RC_REFERENCE_H0	= 0x0910,
> > @@ -277,6 +278,7 @@ enum tpm_chip_flags {
> >  	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
> >  	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
> >  	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
> > +	TPM_CHIP_FLAG_LIMITED_MODE	= BIT(7),
> >  };
> >  
> >  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> > -- 
> > 2.20.1
> > 
> > 
> 
> /Jarkko

Kind regards,
Borys
